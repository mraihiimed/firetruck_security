#pragma once
#include "can_drv.h"
#include "security_common.h"
#include <stdbool.h>

bool gw_firecan_sec_filter(const frame_t *f);
