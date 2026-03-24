#include "routing.h"
#include "can_drv.h"
#include <stdio.h>

void route_chassis_frame(const frame_t *f)
{
    switch (f->pgn) {

        case 0xFEF1:   // Vehicle Speed
        case 0xF004:   // Engine Speed
        case 0xFEE9:   // Fuel Rate
            printf("[GW CHASSIS] Forward PGN=0x%06X\n", f->pgn);
            can_send(f);
            break;

        default:
            printf("[GW CHASSIS] Drop PGN=0x%06X\n", f->pgn);
            break;
    }
}
