
#include "fcntl.h"
#include "types.h"
#include "user.h"

int main(int argc,char **argv)
{
    int fp1, fp2;
    printf(1,"Entering CP, trying to open file");
    char buf[4096];

    if ((fp1 = open(argv[1],O_RDONLY)) == 0)    
    {   
        printf(1,"File cannot be opened");
        return 0; 
    }
    else
     {
        //printf("\nFile opened for copy...\n ");    
    }
    fp2 = open(argv[2], O_CREATE);
    read(fp1,buf,4096);
    write(fp2,buf,4096);  

    close(fp1);
    close(fp2);    
    exit();
}
