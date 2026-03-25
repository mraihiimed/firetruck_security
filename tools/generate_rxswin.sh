#!/bin/bash

OUTPUT="compliance/R156/RXSWIN/rx_swin.json"

hash_file() {
    sha256sum "$1" | awk '{print $1}'
}

MAIN_ECU_HASH=$(hash_file bin/main_ecu)
GW_CHASSIS_HASH=$(hash_file bin/gw_chassis)
GW_FIRECAN_HASH=$(hash_file bin/gw_firecan)
GW_HMI_HASH=$(hash_file bin/gw_hmi)

cat <<EOF > $OUTPUT
{
  "version": "1.0.0",
  "components": {
    "main_ecu": {
      "version": "1.0.0",
      "hash": "SHA256:$MAIN_ECU_HASH"
    },
    "gw_chassis": {
      "version": "1.0.0",
      "hash": "SHA256:$GW_CHASSIS_HASH"
    },
    "gw_firecan": {
      "version": "1.0.0",
      "hash": "SHA256:$GW_FIRECAN_HASH"
    },
    "gw_hmi": {
      "version": "1.0.0",
      "hash": "SHA256:$GW_HMI_HASH"
    }
  }
}
EOF

echo "RXSWIN updated: $OUTPUT"
