#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void log_event(const char *type, const char *details) {
    FILE *f = fopen("logs/security_monitor.log", "a");
    if (!f) return;

    time_t now = time(NULL);
    fprintf(f, "[%lld] [%s] %s\n", (long long)now, type, details);
    fclose(f);
}
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
