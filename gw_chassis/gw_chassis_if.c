#include "gw_chassis_if.h"
#include <stdio.h>

bool gw_chassis_if_process(const frame_t *f)
{
    switch (f->pgn) {

        case 0xFEF1:   // Vehicle Speed
        case 0xF004:   // Engine Speed
        case 0xFEE9:   // Fuel Rate
            can_send(f);
            return true;

        default:
            return false;
    }
}
