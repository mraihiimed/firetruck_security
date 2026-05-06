#!/usr/bin/env bash
set -euo pipefail

# ============================
# CONFIG
# ============================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BIN_DIR="$PROJECT_ROOT/bin"

# OTA output root (NO sudo dependency)
OTA_ROOT="${OTA_ROOT:-$HOME/ota}"
CAMPAIGNS_DIR="$OTA_ROOT/campaigns"
LATEST_JSON="$OTA_ROOT/latest.json"

COMPONENTS=(
  "main_ecu"
  "gw_chassis"
  "gw_firecan"
  "gw_hmi"
  "security_monitor"
)

# ============================
# SAFETY CHECK
# ============================

if [[ "$EUID" -eq 0 ]]; then
  echo "ERROR: Do not run this script as root"
  exit 1
fi

# ============================
# VERSIONING
# ============================

VERSION="$(date +%Y.%m.%d.%H%M)"
CAMPAIGN_ID="$(date +%Y-%m-%d)"
TARGET_DIR="$CAMPAIGNS_DIR/$CAMPAIGN_ID"

mkdir -p "$TARGET_DIR"

echo "=== OTA RELEASE ==="
echo "Version:     $VERSION"
echo "Campaign:    $CAMPAIGN_ID"
echo "Target dir:  $TARGET_DIR"
echo

# ============================
# DEPENDENCIES
# ============================

command -v jq >/dev/null 2>&1 || { echo "ERROR: jq required"; exit 1; }

# ============================
# VALIDATE BIN DIR
# ============================

if [[ ! -d "$BIN_DIR" ]]; then
  echo "ERROR: BIN_DIR not found: $BIN_DIR"
  exit 1
fi

# ============================
# 1) GENERATE IMAGES
# ============================

echo "[1/4] Generating images..."

for comp in "${COMPONENTS[@]}"; do

  BIN_FILE="$(find "$BIN_DIR" -type f -name "${comp}*" | head -n 1)"

  if [[ -z "$BIN_FILE" ]]; then
    echo "WARNING: Missing binary for $comp"
    continue
  fi

  if [[ "$comp" == "gw_hmi" ]]; then
    IMG_FILE="hmi-${VERSION}.img"
  else
    IMG_FILE="${comp}-${VERSION}.img"
  fi

  echo "  - $comp -> $IMG_FILE"
  cp "$BIN_FILE" "$TARGET_DIR/$IMG_FILE"

done

echo

# ============================
# 1.5) HASH + SIGN
# ============================

echo "[1.5/4] Hashing + signing..."

cd "$TARGET_DIR"

sha256sum *.img > SHA256SUMS
#gpg --detach-sign --armor SHA256SUMS
#gpg --batch --yes --detach-sign --armor SHA256SUMS

gpg --batch --yes --pinentry-mode loopback \
    --passphrase "$GPG_PASSPHRASE" \
    --detach-sign --armor SHA256SUMS


echo "  - SHA256SUMS created"
echo "  - SHA256SUMS.asc created"

# ============================
# 2) METADATA
# ============================

echo "[2/4] Building metadata.json..."

cat > metadata.json <<EOF
{
  "version": "$VERSION",
  "campaign_id": "$CAMPAIGN_ID",
  "date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "components": {}
}
EOF

for comp in "${COMPONENTS[@]}"; do

  if [[ "$comp" == "gw_hmi" ]]; then
    IMG_FILE="hmi-${VERSION}.img"
  else
    IMG_FILE="${comp}-${VERSION}.img"
  fi

  if [[ ! -f "$TARGET_DIR/$IMG_FILE" ]]; then
    continue
  fi

  SHA256=$(sha256sum "$IMG_FILE" | awk '{print $1}')
  URL="https://ota.geeksolution.ovh/campaigns/${CAMPAIGN_ID}/${IMG_FILE}"

  jq \
    --arg comp "$comp" \
    --arg file "$IMG_FILE" \
    --arg sha "$SHA256" \
    --arg url "$URL" \
    '.components[$comp] = {
      file: $file,
      sha256: $sha,
      url: $url
    }' metadata.json > tmp.json && mv tmp.json metadata.json

done

echo

echo "[2.5/4] Signing metadata.json..."

gpg --batch --yes --pinentry-mode loopback \
    --passphrase "$GPG_PASSPHRASE" \
    --detach-sign --armor metadata.json

echo "  - metadata.json.asc created"
# ============================
# 3) LATEST UPDATE
# ============================

echo "[3/4] Updating latest.json..."

cat > "$LATEST_JSON" <<EOF
{
  "active_campaign": "$CAMPAIGN_ID"
}
EOF

echo "  - latest.json updated"

echo

# ============================
# 4) DONE
# ============================

echo "[4/4] OTA release complete"
echo "Campaign: $TARGET_DIR"
echo "Metadata:  $TARGET_DIR/metadata.json"
echo "Latest:    $LATEST_JSON"
echo
echo "Endpoints:"
echo "  /api/campaign/latest"
echo "  /api/campaign/$CAMPAIGN_ID"
echo
echo "=== DONE ==="
