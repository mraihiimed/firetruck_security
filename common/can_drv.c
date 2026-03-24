// common/can_drv.c

#include "can_drv.h"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

static int              g_sock_fd      = -1;
static struct sockaddr_in g_remote_addr;
static socklen_t        g_remote_len   = sizeof(g_remote_addr);

/* Simple on‑wire format:
 * [pgn:4][sa:1][len:1][data:8] = 14 bytes
 */

typedef struct __attribute__((packed)) {
    uint32_t pgn;
    uint8_t  sa;
    uint8_t  len;
    uint8_t  data[8];
} wire_frame_t;

bool can_init(const char *local_ip, uint16_t local_port,
              const char *remote_ip, uint16_t remote_port)
{
    struct sockaddr_in local_addr;

    g_sock_fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (g_sock_fd < 0) {
        perror("socket");
        return false;
    }

    memset(&local_addr, 0, sizeof(local_addr));
    local_addr.sin_family      = AF_INET;
    local_addr.sin_port        = htons(local_port);
    local_addr.sin_addr.s_addr = (local_ip && strcmp(local_ip, "0.0.0.0") != 0)
                                 ? inet_addr(local_ip)
                                 : htonl(INADDR_ANY);

    if (bind(g_sock_fd, (struct sockaddr *)&local_addr, sizeof(local_addr)) < 0) {
        perror("bind");
        close(g_sock_fd);
        g_sock_fd = -1;
        return false;
    }

    memset(&g_remote_addr, 0, sizeof(g_remote_addr));
    g_remote_addr.sin_family      = AF_INET;
    g_remote_addr.sin_port        = htons(remote_port);
    g_remote_addr.sin_addr.s_addr = inet_addr(remote_ip);

    return true;
}

bool can_send(const frame_t *f)
{
    if (g_sock_fd < 0 || f == NULL) {
        return false;
    }

    wire_frame_t wf;
    memset(&wf, 0, sizeof(wf));

    wf.pgn = htonl(f->pgn);
    wf.sa  = f->sa;
    wf.len = f->len;
    if (wf.len > 8) {
        wf.len = 8;
    }
    memcpy(wf.data, f->data, wf.len);

    ssize_t sent = sendto(g_sock_fd,
                          &wf,
                          sizeof(wf),
                          0,
                          (struct sockaddr *)&g_remote_addr,
                          g_remote_len);
    if (sent != (ssize_t)sizeof(wf)) {
        perror("sendto");
        return false;
    }

    return true;
}

bool can_recv(frame_t *f)
{
    if (g_sock_fd < 0 || f == NULL) {
        return false;
    }

    wire_frame_t wf;
    struct sockaddr_in src_addr;
    socklen_t src_len = sizeof(src_addr);

    ssize_t recvd = recvfrom(g_sock_fd,
                             &wf,
                             sizeof(wf),
                             0,
                             (struct sockaddr *)&src_addr,
                             &src_len);
    if (recvd < 0) {
        perror("recvfrom");
        return false;
    }
    if (recvd != (ssize_t)sizeof(wf)) {
        // ignore malformed frames for now
        return false;
    }

    f->pgn = ntohl(wf.pgn);
    f->sa  = wf.sa;
    f->len = wf.len;
    if (f->len > 8) {
        f->len = 8;
    }
    memcpy(f->data, wf.data, f->len);
    printf("[ECU] Received frame: PGN=0x%X, len=%d, data=", f->pgn, f->len);
    for(int i=0;i<f->len;i++) printf("%02X ", f->data[i]);
    printf("\n");
    return true;
}

