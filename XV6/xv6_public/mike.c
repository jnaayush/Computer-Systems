#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int
main(int argc, char *argv[])
{
  int i;
    int fp;
    char buf[512] = "Hey this buf for mike.txt\n";
  for(i = 1; i < argc; i++)
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");

  mike();
    fp = open("mike.txt",O_CREATE | O_RDWR);
    for(i = 0 ;i < 100; i++){
       write(fp,buf,512);
    }
    close(fp);
  exit();
}
