#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/md5.h>
#include <limits.h>

const char* string = "bgvyzdsv";

int main() {
    unsigned char digest[MD5_DIGEST_LENGTH];
    char md5str[32];
    int i = 0;

    do {
        ++i;
        snprintf(md5str, 20, "%s%i", string, i);
        MD5((unsigned char*)md5str, strlen(md5str), digest);
    } while (digest[0] != 0 || digest[1] != 0 || digest[2] > 15);

    printf("Part 1: %i\n", i);

    do {
      ++i;
        snprintf(md5str, 20, "%s%i", string, i);
        MD5((unsigned char*)md5str, strlen(md5str), digest);
    } while (digest[0] != 0 || digest[1] != 0 || digest[2] != 0);

    printf("Part 2: %i\n", i);
}
