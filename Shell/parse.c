#include <string.h>
#include <stdio.h>

int main () {
    char str[80];
    const char *delim = "| ";
    char *token;
    
    /* get the first token */
    fgets(str, 80, stdin);
    token = strtok(str, delim);
    /* walk through other tokens */
    while( token != NULL ) {
        printf("%s\n", token );
        token = strtok(NULL, delim);
    }
    
    return(0);
}

