// memory_segments.c
#include <stdio.h>
#include <stdlib.h>

int global_var;
int global_initialized_var = 5;

void function() { // Esta es una función de demostración.
    int stack_var; // Fíjate que tiene el mismo nombre que la de main().
    printf("La variable stack_var de function está en la dirección 0x%08x\n", &stack_var);
}

int main() {
    int stack_var; // Misma variable que en function().
    static int static_initialized_var = 5;
    static int static_var;
    int *heap_var_ptr;

    heap_var_ptr = (int *) malloc(4);

    // Variables en el segmento de datos.
    printf("global_initialized_var está en la dirección 0x%08x\n", &global_initialized_var);
    printf("static_initialized_var está en la dirección 0x%08x\n\n", &static_initialized_var);

    // Variables en el segmento bss.
    printf("static_var está en la dirección 0x%08x\n", &static_var);
    printf("global_var está en la dirección 0x%08x\n\n", &global_var);

    // Variable en el heap.
    printf("heap_var está en la dirección 0x%08x\n\n", heap_var_ptr);

    // Variables en la pila.
    printf("stack_var está en la dirección 0x%08x\n", &stack_var);
    function();
}
