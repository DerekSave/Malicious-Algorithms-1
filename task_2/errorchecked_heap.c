// errorchecked_heap.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void *errorchecked_malloc(unsigned int); // Prototipo de función

int main(int argc, char *argv[]) {
    char *char_ptr; // Puntero a char
    int *int_ptr; // Puntero a int
    int mem_size;

    if (argc < 2) {
        mem_size = 50; // Valor predeterminado
    } else {
        mem_size = atoi(argv[1]);
    }

    printf("\t[+] Asignando %d bytes de memoria en el heap para char_ptr\n", mem_size);
    char_ptr = (char *) errorchecked_malloc(mem_size);
    strcpy(char_ptr, "Esta memoria está en el heap.");
    printf("char_ptr (%p) --> '%s'\n", char_ptr, char_ptr);

    printf("\t[+] Asignando 12 bytes de memoria en el heap para int_ptr\n");
    int_ptr = (int *) errorchecked_malloc(12);
    *int_ptr = 31337;
    printf("int_ptr (%p) --> %d\n", int_ptr, *int_ptr);

    printf("\t[-] Liberando memoria del heap char_ptr...\n");
    free(char_ptr);

    printf("\t[+] Asignando otros 15 bytes para char_ptr\n");
    char_ptr = (char *) errorchecked_malloc(15);
    strcpy(char_ptr, "nueva memoria");
    printf("char_ptr (%p) --> '%s'\n", char_ptr, char_ptr);

    printf("\t[-] Liberando memoria del heap int_ptr...\n");
    free(int_ptr);
    printf("\t[-] Liberando memoria del heap char_ptr...\n");
    free(char_ptr);
}

void *errorchecked_malloc(unsigned int size) {
    void *ptr;
    ptr = malloc(size);
    if (ptr == NULL) {
        fprintf(stderr, "Error: No se pudo asignar memoria en el heap.\n");
        exit(-1);
    }
    return ptr;
}
