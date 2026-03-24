#ifndef POLICY_ENGINE_H
#define POLICY_ENGINE_H

#include "../common/can_drv.h"
#include <stdbool.h>
bool policy_engine_filter(const frame_t *f);
unsigned long get_millis();
#endif
