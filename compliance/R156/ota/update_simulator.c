#include <stdio.h>
#include <stdbool.h>

bool verify_signature(const char *file) {
    printf("[OTA] Verifying signature for %s...\n", file);
    return true;
}

bool verify_hash(const char *file) {
    printf("[OTA] Verifying hash for %s...\n", file);
    return true;
}

void rollback() {
    printf("[OTA] Rolling back to previous version...\n");
}

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: update_simulator <update_file>\n");
        return 1;
    }

    const char *update = argv[1];

    if (!verify_signature(update)) {
        rollback();
        return 1;
    }

    if (!verify_hash(update)) {
        rollback();
        return 1;
    }

    printf("[OTA] Update applied successfully.\n");
    return 0;
}
