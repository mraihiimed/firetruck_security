#include "hmi_cmd.h"
#include <stdio.h>

void hmi_send_pto(uint8_t on)
{
    frame_t f = {0};
    f.pgn = 0xE100;
    f.sa  = 0x21;     // HMI ECU
    f.len = 8;
    f.data[0] = on ? 1 : 0;

    can_send(&f);
    printf("[HMI] PTO command: %s\n", on ? "ON" : "OFF");
}

void hmi_send_pump(uint8_t on)
{
    frame_t f = {0};
    f.pgn = 0xE200;
    f.sa  = 0x21;
    f.len = 8;
    f.data[0] = on ? 1 : 0;

    can_send(&f);
    printf("[HMI] Pump command: %s\n", on ? "ON" : "OFF");
}

void hmi_send_mast(uint8_t up)
{
    frame_t f = {0};
    f.pgn = 0xE300;
    f.sa  = 0x21;
    f.len = 8;
    f.data[0] = up ? 1 : 0;

    can_send(&f);
    printf("[HMI] Mast command: %s\n", up ? "UP" : "DOWN");
}
