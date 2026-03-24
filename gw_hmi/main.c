#include "can_drv.h"
#include "security_common.h"
#include "gw_hmi_if.h"
#include "gw_hmi_sec.h"
#include <stdio.h>

int main(void)
{
    if (!can_init("0.0.0.0", 53000, "192.168.1.100", 50000)) {
        printf("[GW_HMI] ERROR: CAN init failed\n");
        return 1;
    }

    printf("[GW_HMI] Running...\n");

    frame_t f;

    while (1) {
        if (can_recv(&f)) {

            if (!gw_hmi_sec_filter(&f)) {
                printf("[GW_HMI] Dropped by security filter\n");
                continue;
            }

            if (gw_hmi_if_process(&f)) {
                printf("[GW_HMI] Forwarded PGN=0x%06X\n", f.pgn);
            } else {
                printf("[GW_HMI] Dropped PGN=0x%06X\n", f.pgn);
            }
        }
    }

    return 0;
}
