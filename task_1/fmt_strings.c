#include <stdio.h>
int main() {
    char string[10];
    int A = -73;
    unsigned int B = 31337;
    strcpy(string, "sample");
    printf("[A] Dec: %d, Hex: %x, Unsigned: %u\n", A, A, A);
    printf("[B] Dec: %d, Hex: %x, Unsigned: %u\n", B, B, B);
    printf("[string] %s Address %08x\n", string, string);
}

