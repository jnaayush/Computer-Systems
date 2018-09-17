#include <stdio.h>
#include "malloc.h"
#include <omp.h>
const int N = 16;
int
main(int argc, char **argv){
  char *buf[N];
	int i;
	int j;
  size_t size = atoi(argv[1]);
  printf("digraph test_%d\n {\n",size);
#pragma omp parallel for
  for(i=0;i<N;i++) buf[i] = (char*)malloc(size);
#pragma omp parallel for
  for(i=0;i<N;i++){
    for(j=0;j<size;j++)buf[i][j] = 2;
  }
#pragma omp barrier
  for(i=0;i<N;i++){
    free(buf[i]);
    size_t *p = (size_t*)(buf[i]);
    printf("\"%lx\" -> \"%lx\"\n",(p-2),*p);
  }
#pragma omp barrier
  printf("}\n");
}
