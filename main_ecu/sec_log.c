#include "sec_log.h"
#include <stdio.h>

void sec_log_init(void)
{
	//late : file logging
}


void sec_log_event(const char *msg, const frame_t *f)
{
   printf("[SEC] %s: PGN=0x%06X SA=0x%02X LEN=%u\n",
           msg, f->pgn, f->sa, f->len);
}
