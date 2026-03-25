#include "sec_log.h"
#include <stdio.h>

static FILE *logf = NULL;

void sec_log_init(void)
{
    logf = fopen("logs/main_ecu.log", "a");
    if (!logf) {
        printf("[SEC] ERROR: cannot open log file\n");
    }
}

void sec_log_event(const char *msg, const frame_t *f)
{
    // Console output
    printf("[SEC] %s: PGN=0x%06X SA=0x%02X LEN=%u\n",
           msg, f->pgn, f->sa, f->len);

    // File output
    if (logf) {
        fprintf(logf, "[SEC] %s: PGN=0x%06X SA=0x%02X LEN=%u\n",
                msg, f->pgn, f->sa, f->len);
        fflush(logf);
    }
}
