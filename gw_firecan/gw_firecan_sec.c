#include "gw_firecan_sec.h"
#include <stdio.h>
#include <stdint.h>
#include "security_common.h"






bool gw_firecan_sec_filter(const frame_t *f)
{
    // 1) PGN whitelist
    switch (f->pgn) {
        case 0xD100:   // Pump Pressure
        case 0xD200:   // Water Level
        case 0xD300:   // Foam Level
            break;
        default:
            printf("[GW_FIRECAN_SEC] DROP: PGN 0x%06X not allowed\n", f->pgn);
            return false;
    }

    // 2) SA check: FireCAN must be SA 0x61
    if (f->sa != 0x61) {
        printf("[GW_FIRECAN_SEC] DROP: Invalid SA 0x%02X for FireCAN PGN 0x%06X\n",
               f->sa, f->pgn);
        return false;
    }

    // 3) DLC check
    if (f->len < 1) {
        printf("[GW_FIRECAN_SEC] DROP: Invalid DLC %u\n", f->len);
        return false;
    }

    // 4) DoS detection
    static uint32_t last_pgn = 0;
    static uint32_t last_time = 0;
    static uint32_t burst = 0;

    uint32_t now = get_millis();

    if (f->pgn == last_pgn && (now - last_time) < 5) {
        burst++;
        if (burst > 20) {
            printf("[GW_FIRECAN_SEC] DROP: DoS detected on PGN 0x%06X\n", f->pgn);
            return false;
        }
    } else {
        burst = 0;
    }

    last_pgn = f->pgn;
    last_time = now;

    return true;
}
