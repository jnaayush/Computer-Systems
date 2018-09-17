 #include "fcntl.h"
#include "types.h"
#include "user.h" 
 int main(int argc,char **argv)
{
    printf(1,"Copying %s to %s\n",argv[1],argv[2]);
    int fp1;
    int fp2;
    char buf[1024];
    fp1 = open(argv[1],O_RDONLY);
    fp2 = open(argv[2],O_CREATE | O_RDWR);
    
    int numRead;
    while ((numRead = read(fp1,buf,1024)) > 0)
    {
         if (write(fp2, buf, numRead) != numRead)
            {
                printf(1,"couldn't write whole buffer");
                exit();
            }
    }
    printf(1,"Copying finished\n");
    close(fp1);
    close(fp2);
    exit();
}
