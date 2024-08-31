#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include "hacking.h"

#define FILENAME "/tmp"

// Funciones declaradas
int print_notes(int, int, char *);  // Función para imprimir notas
int find_user_note(int, int);       // Función para buscar la nota de un usuario
int search_note(char *, char *);    // Función para buscar una palabra clave
void fatal(char *);                 // Función para manejar errores fatales

int main(int argc, char *argv[]) {
    int userid, printing = 1, fd;   // Descriptor de archivo y bandera de impresión
    char searchstring[100];

    // Comprobar si hay argumento de búsqueda
    if (argc > 1) {
        strcpy(searchstring, argv[1]);  // Usar argumento como cadena de búsqueda
    } else {
        searchstring[0] = 0;           // Cadena de búsqueda vacía
    }

    userid = getuid();  // Obtener el UID del usuario
    fd = open(FILENAME, O_RDONLY);  // Abrir el archivo para lectura
    if (fd == -1) {
        fatal("in main() while opening file for reading");
    }

    // Imprimir notas mientras haya más notas
    while (printing) {
        printing = print_notes(fd, userid, searchstring);
    }

    printf("-------[ end of note data ]-------\n");
    close(fd);  // Cerrar archivo

    return 0;
}

// Función para imprimir las notas de un usuario que coincidan con una cadena de búsqueda opcional
// Retorna 0 si el archivo ha terminado, 1 si aún hay más notas.
int print_notes(int fd, int uid, char *searchstring) {
    int note_length;
    char note_buffer[100];

    note_length = find_user_note(fd, uid);
    if (note_length == -1) {  // Si se ha alcanzado el final del archivo
        return 0;  // Retornar 0
    }

    read(fd, note_buffer, note_length);  // Leer los datos de la nota
    note_buffer[note_length] = '\0';     // Terminar la cadena

    if (search_note(note_buffer, searchstring)) {  // Si se encuentra la cadena de búsqueda
        printf("%s", note_buffer);  // Imprimir la nota
    }

    return 1;
}

// Función para encontrar la próxima nota de un UID dado
// Retorna -1 si se alcanza el final del archivo, de lo contrario retorna la longitud de la nota encontrada.
int find_user_note(int fd, int user_uid) {
    int note_uid = -1;
    unsigned char byte;
    int length = 0;

    while (note_uid != user_uid) {  // Repetir hasta encontrar una nota del usuario
        if (read(fd, &note_uid, 4) != 4) {  // Leer el UID de la nota
            return -1;  // Si no se leen 4 bytes, se ha alcanzado el final del archivo
        }

        if (read(fd, &byte, 1) != 1) {  // Leer el separador de nueva línea
            return -1;
        }

        length = 0;
        byte = 0;

        // Contar los bytes hasta el final de la línea
        while (byte != '\n') {
            if (read(fd, &byte, 1) != 1) {
                return -1;
            }
            length++;
        }
    }

    lseek(fd, length * -1, SEEK_CUR);  // Retroceder para leer la nota
    printf("[DEBUG] found a %d byte note for user id %d\n", length, note_uid);
    return length;
}

// Función para buscar una palabra clave en la nota
// Retorna 1 si se encuentra una coincidencia, 0 si no se encuentra.
int search_note(char *note, char *keyword) {
    int i, keyword_length, match = 0;

    keyword_length = strlen(keyword);
    if (keyword_length == 0) {  // Si no hay cadena de búsqueda
        return 1;  // Siempre hay coincidencia
    }

    // Iterar sobre los bytes de la nota
    for (i = 0; i < strlen(note); i++) {
        if (note[i] == keyword[match]) {  // Si el byte coincide con la palabra clave
            match++;  // Prepararse para verificar el siguiente byte
        } else {
            if (note[i] == keyword[0]) {  // Si ese byte coincide con el primer byte de la palabra clave
                match = 1;  // Comenzar el conteo de coincidencias
            } else {
                match = 0;  // Reiniciar coincidencia
            }
        }

        if (match == keyword_length) {  // Si se encuentra una coincidencia completa
            return 1;  // Retornar coincidencia encontrada
        }
    }

    return 0;  // No se encontró coincidencia
}

