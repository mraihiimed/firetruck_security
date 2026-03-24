#include "gw_chassis_sec.h"
#include <stdio.h>
#include <stdint.h>
#include <sys/time.h>
#include "security_common.h"


/*typedef struct timeval tv;  // tv is now an alias for struct timeval

unsigned long get_millis() {
    tv t;  // same as struct timeval t;
    gettimeofday(&t, NULL);
    return t.tv_sec * 1000UL + t.tv_usec / 1000UL;
}
*/

// Allowed PGNs on chassis bus
static const uint32_t allowed_pgns[] = {
    0xFEF1,   // Vehicle Speed
    0xF004,   // Engine Speed
    0xFEE9    // Fuel Rate
};

static bool is_pgn_allowed(uint32_t pgn)
{
    for (unsigned i = 0; i < sizeof(allowed_pgns)/sizeof(allowed_pgns[0]); i++) {
        if (allowed_pgns[i] == pgn)
            return true;
    }
    return false;
}

bool gw_chassis_sec_filter(const frame_t *f)
{
    // 1) PGN whitelist
    if (!is_pgn_allowed(f->pgn)) {
        printf("[GW_CHASSIS_SEC] DROP: PGN 0x%06X not allowed\n", f->pgn);
        return false;
    }

    // 2) SA check: chassis PGNs must come from SA 0x11
    if (f->sa != 0x11) {
        printf("[GW_CHASSIS_SEC] DROP: Invalid SA 0x%02X for PGN 0x%06X\n",
               f->sa, f->pgn);
        return false;
    }

    // 3) Basic plausibility checks
    if (f->len != 8) {
        printf("[GW_CHASSIS_SEC] DROP: Invalid DLC %u\n", f->len);
        return false;
    }

    // 4) Optional: simple DoS detection (per-PGN rate limiting)
    static uint32_t last_pgn = 0;
    static uint32_t last_time = 0;
    static uint32_t burst = 0;

    uint32_t now = get_millis();

    if (f->pgn == last_pgn && (now - last_time) < 5) {
        burst++;
        if (burst > 20) {
            printf("[GW_CHASSIS_SEC] DROP: DoS detected on PGN 0x%06X\n", f->pgn);
            return false;
        }
    } else {
        burst = 0;
    }

    last_pgn = f->pgn;
    last_time = now;

    return true;
}
