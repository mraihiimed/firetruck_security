#include "can_drv.h"
#include "routing.h"
#include <stdio.h>

int main(void)
{
    // Listen on 53000 (FireCAN side), forward to Main ECU at 50000
    if (!can_init("0.0.0.0", 53000, "192.168.1.100", 50000)) {
        printf("GW FireCAN: CAN init failed\n");
        return 1;
    }

    printf("GW FireCAN running...\n");

    frame_t f;
    while (1) {
        if (can_recv(&f)) {
            route_firecan_frame(&f);
        }
    }

    return 0;
}
