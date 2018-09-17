#include <stdio.h>

int main( )  {
    char *arg[50];
    fgets(arg,"%s",stdin);
    printf("The argument supplied is %s\n", arg);
}
