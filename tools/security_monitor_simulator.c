#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>



int fresh_mode = 0;
/*void log_event(const char *type, const char *details) {
    FILE *f = fopen("logs/security_monitor.log", "a");
    if (!f) return;

    time_t now = time(NULL);
    fprintf(f, "[%lld] [%s] %s\n", (long long)now, type, details);
    fclose(f);
}*/

/*void log_event(const char *event_type, const char *pgn, const char *sa, const char *decision) {
    FILE *f = fopen("logs/security_monitor.log", "w"); //overwrite mode
    if (!f) return;

    time_t now = time(NULL);
    struct tm *t = localtime(&now);

    char timestamp[32];
    strftime(timestamp, sizeof(timestamp), "%Y-%m-%d %H:%M:%S", t);

    fprintf(f, "%s | PGN %s | SA %s | %s | %s\n",
            timestamp, pgn, sa, event_type, decision);

    fclose(f);
}*/
/*
void simulate_spoofing() {
    printf("[SIM] Spoofing attack simulated (PGN 0xFEF1)\n");
    log_event("ATTACK", "Spoofing of PGN 0xFEF1 detected");
}

void simulate_dos() {
    printf("[SIM] DoS attack simulated\n");
    log_event("ATTACK", "DoS burst detected on gateway");
}

void simulate_replay() {
    printf("[SIM] Replay attack simulated\n");
    log_event("ATTACK", "Replay of valid frame detected");
}

void simulate_firecan_injection() {
    printf("[SIM] FireCAN sensor injection simulated\n");
    log_event("ATTACK", "Injected PGN 0xD100 (Pump Pressure)");
}

void simulate_hmi_manipulation() {
    printf("[SIM] HMI manipulation simulated\n");
    log_event("ATTACK", "Unauthorized HMI command detected");
}
*/



void log_event(const char *event_type, const char *pgn, const char *sa, const char *decision) {

    FILE *f;

    if (fresh_mode)
        f = fopen("logs/security_monitor.log", "a");   // append after header
    else
        f = fopen("logs/security_monitor.log", "a");   // normal append

    if (!f) return;

    time_t now = time(NULL);
    struct tm *t = localtime(&now);

    char timestamp[32];
    strftime(timestamp, sizeof(timestamp), "%Y-%m-%d %H:%M:%S", t);

    fprintf(f, "%s | PGN %s | SA %s | %s | %s\n",
            timestamp, pgn, sa, event_type, decision);

    fclose(f);
}

void simulate_spoofing() {
    printf("[SIM] Spoofing attack simulated (PGN 0xFEF1)\n");
    log_event("SPOOF_ATTEMPT", "0xFEF1", "0x45", "BLOCKED");
}

void simulate_dos() {
    printf("[SIM] DoS attack simulated\n");
    log_event("DOS_FLOOD", "0x0CF004", "0x12", "RATE_LIMITED");
}

void simulate_replay() {
    printf("[SIM] Replay attack simulated\n");
    log_event("REPLAY_ATTACK", "0x18FEF1", "0x33", "REJECTED");
}

void simulate_firecan_injection() {
    printf("[SIM] FireCAN sensor injection simulated\n");
    log_event("INJECTION", "0xD100", "0x22", "BLOCKED");
}

void simulate_hmi_manipulation() {
    printf("[SIM] HMI manipulation simulated\n");
    log_event("HMI_TAMPER", "0x1FF001", "0x01", "REJECTED");
}




void update_monitoring_snapshot() {
    FILE *f = fopen("compliance/R155/CSMS/snapshots/monitoring_auto.json", "w");
    if (!f) return;

    time_t now = time(NULL);

    fprintf(f,
        "{\n"
        "  \"timestamp\": %lld,\n"
        "  \"last_attack_detected\": \"See security_monitor.log\",\n"
        "  \"forensic_data_available\": true,\n"
        "  \"status\": \"Monitoring active\"\n"
        "}\n",
        (long long)now
    );

    fclose(f);
    printf("[SIM] Monitoring snapshot updated\n");
}

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: security_monitor_simulator <attack>\n");
        printf("Attacks: spoof, dos, replay, firecan, hmi\n");
        return 1;
    }

//    int fresh = 0;

    if (argc >= 3 && strcmp(argv[2], "--fresh") == 0) {
    fresh_mode = 1;
    FILE *f = fopen("logs/security_monitor.log", "w");
    if (f) {
        fprintf(f, "# Firetruck Security Platform — Security Monitoring Log\n");
        fclose(f);
       }
    }


    if (strcmp(argv[1], "spoof") == 0) simulate_spoofing();
    else if (strcmp(argv[1], "dos") == 0) simulate_dos();
    else if (strcmp(argv[1], "replay") == 0) simulate_replay();
    else if (strcmp(argv[1], "firecan") == 0) simulate_firecan_injection();
    else if (strcmp(argv[1], "hmi") == 0) simulate_hmi_manipulation();
    else {
        printf("Unknown attack type.\n");
        return 1;
    }

    update_monitoring_snapshot();
    return 0;
}
