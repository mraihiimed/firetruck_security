#include "routing.h"
#include "can_drv.h"
#include <stdio.h>

void route_firecan_frame(const frame_t *f)
{
    switch (f->pgn) {

        case 0xD100:   // Pump Pressure
        case 0xD200:   // Water Level
        case 0xD300:   // Foam Level
            printf("[GW FIRECAN] Forward PGN=0x%06X\n", f->pgn);
            can_send(f);
            break;

        default:
            printf("[GW FIRECAN] Drop PGN=0x%06X\n", f->pgn);
            break;
    }
}
