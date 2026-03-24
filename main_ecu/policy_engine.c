#include "sec_log.h"
#include <sys/time.h>
#include <stddef.h>
#include <stdio.h>
#include <stdbool.h>
#include "can_drv.h"
#include "security_common.h"
/*
typedef struct timeval tv;

unsigned long get_millis() {
    tv t;
    gettimeofday(&t, NULL);
    return t.tv_sec * 1000UL + t.tv_usec / 1000UL;
}*/

static uint32_t last_timestamp = 0;
static uint32_t last_pgn = 0;
static uint32_t burst_count = 0;

bool policy_engine_filter(const frame_t *f) {

    // -----------------------------
    // 1) DoS detection
    // -----------------------------
    uint32_t now = get_millis();
    if (f->pgn == last_pgn && (now - last_timestamp) < 5) {
        burst_count++;
        if (burst_count > 20) {
            sec_log_event("DoS detected", f);
            return false;
        }
    } else {
        burst_count = 0;
    }
    last_timestamp = now;
    last_pgn = f->pgn;

    // -----------------------------
    // 2) PGN whitelist
    // -----------------------------
    switch (f->pgn) {
        case 0xFEF1:   // Speed
        case 0xF004:   // RPM
        case 0xFEE9:   // Fuel
        case 0xE100:   // PTO cmd
        case 0xE200:   // Pump cmd
        case 0xE300:   // Mast cmd
        case 0xD100:   // Pressure
        case 0xD200:   // Water level
        case 0xD300:   // Foam level
            break;
        default:
            sec_log_event("PGN not allowed", f);
            return false;
    }

    // -----------------------------
    // 3) SA validation
    // -----------------------------
    // Chassis PGNs
    if ((f->pgn == 0xFEF1 || f->pgn == 0xF004 || f->pgn == 0xFEE9) &&
        f->sa != 0x11)
    {
        sec_log_event("Invalid SA for chassis PGN", f);
        return false;
    }

    // HMI PGNs
    if ((f->pgn == 0xE100 || f->pgn == 0xE200 || f->pgn == 0xE300) &&
        f->sa != 0x21)
    {
        sec_log_event("Invalid SA for HMI PGN", f);
        return false;
    }

    // FireCAN PGNs
    if ((f->pgn == 0xD100 || f->pgn == 0xD200 || f->pgn == 0xD300) &&
        f->sa != 0x61)
    {
        sec_log_event("Invalid SA for FireCAN PGN", f);
        return false;
    }

    // -----------------------------
    // 4) Plausibility checks
    // -----------------------------
    if (f->pgn == 0xFEF1) {
        uint16_t raw = (f->data[1] << 8) | f->data[0];
        float speed = raw * 0.00390625f;
        if (speed > 150.0f) {
            sec_log_event("Impossible speed value", f);
            return false;
        }
    }

    if (f->pgn == 0xF004) {
        uint16_t raw = (f->data[1] << 8) | f->data[0];
        float rpm = raw * 0.125f;
        if (rpm > 4000.0f) {
            sec_log_event("Impossible RPM value", f);
            return false;
        }
    }

    if (f->pgn == 0xFEE9) {
        uint16_t raw = (f->data[1] << 8) | f->data[0];
        float fuel = raw * 0.05f;
        if (fuel > 200.0f) {
            sec_log_event("Impossible fuel rate", f);
            return false;
        }
    }

    return true;
}
