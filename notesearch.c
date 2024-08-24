#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include "hacking.h"

#define FILENAME "/var/notes"

int print_notes(int, int, char *);
int find_user_note(int, int);
int search_note(char *, char *);
void fatal(char *);

int main(int argc, char *argv[]) {
    int userid, printing = 1, fd;
    char searchstring[100];

    if (argc > 1) strcpy(searchstring, argv[1]);
    else searchstring[0] = 0;

    userid = getuid();
    fd = open(FILENAME, O_RDONLY);
    if (fd == -1) fatal("in main() while opening file for reading");

    while (printing) printing = print_notes(fd, userid, searchstring);

    printf("-------[ end of note data ]-------\n");
    close(fd);
}
