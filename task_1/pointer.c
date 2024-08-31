#include <stdio.h>
#include <string.h>
int main() {
    char str_a[20]; // Un arreglo de 20 caracteres
    char *pointer;  // Un puntero para un arreglo de caracteres
    char *pointer2; // Otro puntero
    strcpy(str_a, "Hello, world!\n");
    pointer = str_a; // Apunta al inicio del arreglo
    printf(pointer);
    pointer2 = pointer + 2; // Apunta 2 bytes más adelante
    printf(pointer2); // Imprime desde ese punto
    strcpy(pointer2, "y you guys!\n"); // Copia en esa ubicación
    printf(pointer); // Imprime de nuevo
}
