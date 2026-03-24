#include "can_drv.h"
#include "policy_engine.h"
#include "state_model.h"
#include "sec_log.h"
#include <stdio.h>


int main(void)
{
	//main_pi: local 192.168.1.20:50000, remote = 192.168.1.10:50001
	if(!can_init("0.0.0.0",50000,"192.168.1.109",50001))
	{
		printf("CAN init main Ecu failed \n");
		return 1;
	}
	sec_log_init();
	frame_t f;
	while(can_recv(&f))
	{
		if(!policy_engine_filter(&f))
		{
			//sec_log_event("Frame blocked by policy", &f);
			//sec_log_event("[SEC] Frame blocked by policy PGN=0x%06X SA=0x%02X LEN=%u\n",
			//		f.pgn, f.sa, f.len);
			printf("[SEC] Frame blocked by policy: PGN=0x%06X SA=0x%02X LEN=%u\n",
                   	f.pgn, f.sa, f.len);
			 continue;
		}
		state_model_update(&f);
	}
	return 0;

}
