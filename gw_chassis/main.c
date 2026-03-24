#include "can_drv.h"
#include "routing.h"
#include "gw_chassis_if.h"
#include "gw_chassis_sec.h"
#include <stdio.h>

int main(void)
{
    if (!can_init("0.0.0.0", 51000, "192.168.1.100", 50000)) {
        printf("GW chassis: CAN init failed\n");
        return 1;
    }
   printf("GW chassis running ...\n");
   frame_t f;
   while(1)
   {
      if(can_recv(&f))
      {
	 // Security filter (SA, PGN, plausibility, DoS…)
            if (!gw_chassis_sec_filter(&f)) {
                printf("[GW_CHASSIS] Dropped by security filter\n");
                continue;
            }

            // Interface routing (forward allowed PGNs)
            if (gw_chassis_if_process(&f)) {
                printf("[GW_CHASSIS] Forwarded PGN=0x%06X\n", f.pgn);
            } else {
                printf("[GW_CHASSIS] Dropped PGN=0x%06X\n", f.pgn);
            }
         //route_chassis_frame(&f);

      }

   }
return 0;

}
