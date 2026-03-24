#ifndef CAN_DRV_H
#define CAN_DRV_H
#include <stdint.h>
#include <stdbool.h>

typedef struct {
	uint32_t pgn;
	uint8_t sa;
	uint8_t len;
	uint8_t data[8];
}frame_t;


bool can_init(const char *local_ip, uint16_t local_port, 
	const char *remote_ip, uint16_t remote_port);
bool can_send(const frame_t *f);
bool can_recv(frame_t *f); //blocking for now

#endif
