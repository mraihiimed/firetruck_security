#include "gw_hmi_if.h"
#include <stdio.h>

bool gw_hmi_if_process(const frame_t *f)
{
    switch (f->pgn) {

        case 0xE100:   // PTO Command
        case 0xE200:   // Pump Command
        case 0xE300:   // Mast Command
            // Forward to Main ECU
            can_send(f);
            return true;

        default:
            return false;
    }
}
