// heap_example.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *char_ptr; // Un puntero a char
    int *int_ptr; // Un puntero a int
    int mem_size;

    if (argc < 2) {
        mem_size = 50; // Valor predeterminado
    } else {
        mem_size = atoi(argv[1]);
    }

    printf("\t[+] Asignando %d bytes de memoria en el heap para char_ptr\n", mem_size);
    char_ptr = (char *) malloc(mem_size);

    if (char_ptr == NULL) {
        fprintf(stderr, "Error: No se pudo asignar memoria en el heap.\n");
        exit(-1);
    }

    strcpy(char_ptr, "Esta memoria está en el heap.");
    printf("char_ptr (%p) --> '%s'\n", char_ptr, char_ptr);

    printf("\t[+] Asignando 12 bytes de memoria en el heap para int_ptr\n");
    int_ptr = (int *) malloc(12);

    if (int_ptr == NULL) {
        fprintf(stderr, "Error: No se pudo asignar memoria en el heap.\n");
        exit(-1);
    }

    *int_ptr = 31337;
    printf("int_ptr (%p) --> %d\n", int_ptr, *int_ptr);

    printf("\t[-] Liberando memoria del heap char_ptr...\n");
    free(char_ptr);

    printf("\t[+] Asignando otros 15 bytes para char_ptr\n");
    char_ptr = (char *) malloc(15);

    if (char_ptr == NULL) {
        fprintf(stderr, "Error: No se pudo asignar memoria en el heap.\n");
        exit(-1);
    }

    strcpy(char_ptr, "nueva memoria");
    printf("char_ptr (%p) --> '%s'\n", char_ptr, char_ptr);

    printf("\t[-] Liberando memoria del heap int_ptr...\n");
    free(int_ptr);
    printf("\t[-] Liberando memoria del heap char_ptr...\n");
    free(char_ptr);
}
