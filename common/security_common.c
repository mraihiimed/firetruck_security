#include "security_common.h"
#include <sys/time.h>
#include <stddef.h>
#include <stdio.h>
typedef struct timeval tv;

void detect_attack(int can_id) {
    if (can_id == 0x999) {
        FILE *f = fopen("logs/security_monitor.log", "a");
        fprintf(f, "[ATTACK] Suspicious CAN ID detected: 0x%X\n", can_id);
        fclose(f);
    }
}
unsigned long get_millis(void)
{
    tv t;
    gettimeofday(&t, NULL);
    return t.tv_sec * 1000UL + t.tv_usec / 1000UL;
}
