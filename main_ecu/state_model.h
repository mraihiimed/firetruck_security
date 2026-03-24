#ifndef STATE_MODEL_H
#define STATE_MODEL_H

#include "can_drv.h"

typedef enum {
    PTO_OFF = 0,
    PTO_ON  = 1
} pto_state_t;

typedef enum {
    PUMP_OFF = 0,
    PUMP_ON  = 1
} pump_state_t;

typedef enum {
    MAST_DOWN = 0,
    MAST_UP   = 1
} mast_state_t;


void state_model_update(const frame_t *f);

#endif
