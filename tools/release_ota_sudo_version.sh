#!/bin/bash
set -euo pipefail

# ============================
# PATH RESOLUTION (ROBUST)
# ============================

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# Detect project root
if [[ -d "$SCRIPT_DIR/../bin" ]]; then
  PROJECT_ROOT="$(realpath "$SCRIPT_DIR/..")"
elif [[ -d "$SCRIPT_DIR/bin" ]]; then
  PROJECT_ROOT="$SCRIPT_DIR"
else
  echo "ERROR: Cannot locate project root (bin/ not found)"
  exit 1
fi

BIN_DIR="$PROJECT_ROOT/bin"

echo "DEBUG: SCRIPT_DIR=$SCRIPT_DIR"
echo "DEBUG: PROJECT_ROOT=$PROJECT_ROOT"
echo "DEBUG: BIN_DIR=$BIN_DIR"

# ============================
# OTA CONFIG
# ============================

OTA_ROOT="/var/www/ota"
CAMPAIGNS_DIR="$OTA_ROOT/campaigns"
LATEST_JSON="$OTA_ROOT/latest.json"

# Components (logical names)
COMPONENTS=(
  "main_ecu"
  "gw_chassis"
  "gw_firecan"
  "gw_hmi"
  "security_monitor"
)

# ============================
# VERSIONING
# ============================

VERSION="$(date +%Y.%m.%d.%H%M)"
CAMPAIGN_ID="$(date +%Y-%m-%d)"
TARGET_DIR="$CAMPAIGNS_DIR/$CAMPAIGN_ID"

mkdir -p "$TARGET_DIR"

echo "=== OTA RELEASE ==="
echo "Version:      $VERSION"
echo "Campaign ID:  $CAMPAIGN_ID"
echo "Target dir:   $TARGET_DIR"
echo

# ============================
# CHECK DEPENDENCIES
# ============================

if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is required"
  exit 1
fi

# ============================
# VALIDATE BIN DIR
# ============================

if [[ ! -d "$BIN_DIR" ]]; then
  echo "ERROR: BIN_DIR not found: $BIN_DIR"
  exit 1
fi

# ============================
# 1) GENERATE .img FILES
# ============================

echo "[1/4] Generating images..."

for comp in "${COMPONENTS[@]}"; do

  # IMPORTANT FIX:
  # Your real binaries have NO .bin extension
  BIN_FILE="$(find "$BIN_DIR" -type f -name "${comp}*" | head -n 1)"

  if [[ -z "$BIN_FILE" || ! -f "$BIN_FILE" ]]; then
    echo "WARNING: Missing binary for $comp"
    continue
  fi

  # Naming rules
  if [[ "$comp" == "gw_hmi" ]]; then
    IMG_FILE="media-${VERSION}.img"
  else
    IMG_FILE="${comp}-${VERSION}.img"
  fi

  echo "  - $comp -> $IMG_FILE"

  cp "$BIN_FILE" "$TARGET_DIR/$IMG_FILE"

done

echo

echo "[1.5/4] Generating hashes and signatures..."

cd "$TARGET_DIR"

# 1. Generate SHA256 manifest for all images
sha256sum *.img > SHA256SUMS

# 2. Sign the SHA256 file (this is your trust anchor)
gpg --detach-sign --armor SHA256SUMS

echo "  - SHA256SUMS created"
echo "  - SHA256SUMS.asc created"

# ============================
# 2) BUILD metadata.json
# ============================

echo "[2/4] Building metadata.json..."

cat > "$TARGET_DIR/metadata.json" <<EOF
{
  "version": "$VERSION",
  "campaign_id": "$CAMPAIGN_ID",
  "date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "components": {}
}
EOF

for comp in "${COMPONENTS[@]}"; do

  if [[ "$comp" == "gw_hmi" ]]; then
    IMG_FILE="media-${VERSION}.img"
  else
    IMG_FILE="${comp}-${VERSION}.img"
  fi

  if [[ ! -f "$TARGET_DIR/$IMG_FILE" ]]; then
    echo "  - Skipping $comp (no image)"
    continue
  fi

  SHA256=$(sha256sum "$TARGET_DIR/$IMG_FILE" | awk '{print $1}')
  URL="https://ota.geeksolution.ovh/campaigns/${CAMPAIGN_ID}/${IMG_FILE}"

  echo "  - $comp added"

  jq --arg comp "$comp" \
     --arg file "$IMG_FILE" \
     --arg sha "$SHA256" \
     --arg url "$URL" \
     '
     .components[$comp] = {
       "file": $file,
       "sha256": $sha,
       "url": $url
     }
     ' "$TARGET_DIR/metadata.json" > "$TARGET_DIR/metadata.tmp" \
     && mv "$TARGET_DIR/metadata.tmp" "$TARGET_DIR/metadata.json"

done

echo

# ============================
# 3) UPDATE latest.json
# ============================

echo "[3/4] Updating latest.json..."

cat > "$LATEST_JSON" <<EOF
{
  "active_campaign": "$CAMPAIGN_ID"
}
EOF

echo "  - latest updated"

echo

# ============================
# 4) SUMMARY
# ============================

echo "[4/4] Release complete"
echo "Campaign folder: $TARGET_DIR"
echo "Metadata:        $TARGET_DIR/metadata.json"
echo "Latest:          $LATEST_JSON"
echo
echo "API:"
echo "  GET /api/campaign/latest"
echo "  GET /api/campaign/${CAMPAIGN_ID}"
echo
echo "=== DONE ==="
