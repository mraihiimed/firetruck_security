#ifndef SEC_LOG_H
#define SEC_LOG_H

#include "../common/can_drv.h"

void sec_log_init(void);
void sec_log_event(const char *msg, const frame_t *f);


#endif
