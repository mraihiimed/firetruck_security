#include "state_model.h"
#include "sec_log.h"
#include <stdio.h>



static pto_state_t  pto_state  = PTO_OFF;
static pump_state_t pump_state = PUMP_OFF;
static mast_state_t mast_state = MAST_DOWN;





static const char* sa_to_name(uint8_t sa)
{
    switch (sa) {
        case 0x01: return "Main ECU";
        case 0x11: return "Chassis Gateway";
        case 0x21: return "HMI ECU";
        case 0x61: return "FireCAN Gateway";
        default:   return "Unknown ECU";
    }
}

void state_model_update(const frame_t *f)
{
    // Log the frame
    sec_log_event("State update from frame", f);

    // Decode SA (source address)
    const char *ecu_name = sa_to_name(f->sa);
    printf("[ECU] From SA=0x%02X (%s)\n", f->sa, ecu_name);

    // Decode PGN
    switch (f->pgn)
    {
        case 0xFEF1: {   // Vehicle Speed
            //uint8_t raw = f->data[0];
	    uint16_t raw = (f->data[1] << 8)| f->data[0];
            //unsigned int speed_kmh = raw;      // simple scaling
	    float speed_kmh = raw * 0.00390625f;
            printf("[ECU] Vehicle speed = %.2f km/h (raw=%u)\n",
                   speed_kmh, raw);
            break;
        }

        case 0xF004: {   // Engine Speed
            uint16_t raw = (f->data[1] << 8) | f->data[0];
            //unsigned int rpm = raw;            // simple scaling
	    float rpm = raw * 0.125f;
            printf("[ECU] Engine speed = %.2f rpm (raw=%u)\n", rpm, raw);
            break;
        }
	case 0xFEE9: {   // Fuel Rate (SPN 183)
            uint16_t raw = (f->data[1] << 8) | f->data[0];
            float fuel_rate = raw * 0.05f;

    	    printf("[ECU] Fuel rate = %.2f L/h (raw=%u)\n",
            fuel_rate, raw);
    	    break;
	}
	case 0xE100: {   // PTO Command
        uint8_t cmd = f->data[0];

        if (cmd == 1 && pto_state == PTO_OFF) {
           printf("[ECU] PTO -> ON\n");
           pto_state = PTO_ON;
        }
        else if (cmd == 0 && pto_state == PTO_ON) {
        if (mast_state == MAST_UP) {
            printf("[ECU] REFUSE: Cannot turn PTO off while mast is UP\n");
        } else {
            printf("[ECU] PTO -> OFF\n");
            pto_state = PTO_OFF;
        }
        }
        break;
	}
	case 0xE200: {   // Pump Command
   	uint8_t cmd = f->data[0];

        if (cmd == 1) {
        if (pto_state == PTO_OFF) {
            printf("[ECU] REFUSE: Pump ON requires PTO ON\n");
        } else {
            printf("[ECU] Pump -> ON\n");
            pump_state = PUMP_ON;
        }
        }
        else if (cmd == 0) {
           printf("[ECU] Pump -> OFF\n");
           pump_state = PUMP_OFF;
        }
        break;
        }
	case 0xE300: {   // Mast Command
        uint8_t cmd = f->data[0];

        if (cmd == 1) {  // Mast UP
        if (pto_state == PTO_OFF) {
            printf("[ECU] REFUSE: Mast UP requires PTO ON\n");
        }
        else if (pump_state == PUMP_ON) {
            printf("[ECU] REFUSE: Mast cannot move while pump is ON\n");
        }
        else {
            printf("[ECU] Mast -> UP\n");
            mast_state = MAST_UP;
        }
        }
        else if (cmd == 0) {  // Mast DOWN
            printf("[ECU] Mast -> DOWN\n");
            mast_state = MAST_DOWN;
        }
        break;
        }

        default:
            printf("[ECU] Received PGN=0x%06X, LEN=%u\n",
                   f->pgn, f->len);
            break;
    }

}
