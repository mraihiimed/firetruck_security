#include "can_drv.h"
#include "hmi_cmd.h"
#include <stdio.h>
#include <unistd.h>

int main(void)
{
    if (!can_init("0.0.0.0", 52000, "192.168.1.100", 50000)) {
        printf("HMI ECU: CAN init failed\n");
        return 1;
    }

    printf("HMI ECU running...\n");
    printf("Commands:\n");
    printf("  1 = PTO ON\n");
    printf("  2 = PTO OFF\n");
    printf("  3 = Pump ON\n");
    printf("  4 = Pump OFF\n");
    printf("  5 = Mast UP\n");
    printf("  6 = Mast DOWN\n");

    while (1) {
        int cmd;
        printf("Enter command: ");
        scanf("%d", &cmd);

        switch (cmd) {
            case 1: hmi_send_pto(1); break;
            case 2: hmi_send_pto(0); break;
            case 3: hmi_send_pump(1); break;
            case 4: hmi_send_pump(0); break;
            case 5: hmi_send_mast(1); break;
            case 6: hmi_send_mast(0); break;
            default:
                printf("Unknown command\n");
                break;
        }
    }

    return 0;
}
