#include "security_common.h"
#include <sys/time.h>
#include <stddef.h>
typedef struct timeval tv;

unsigned long get_millis(void)
{
    tv t;
    gettimeofday(&t, NULL);
    return t.tv_sec * 1000UL + t.tv_usec / 1000UL;
}
