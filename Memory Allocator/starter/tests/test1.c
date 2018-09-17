#include <stdio.h>
#include <pthread.h>
#include <assert.h>
#include "malloc.h"

#define N_THREAD 64

void *dataFunc(){
    int *data[10000];
    for(int i = 0; i < 10000; i++){
        data[i] = (int*)malloc(rand()%4096);
    }
    
    for(int i = 0; i < 10000; i++){
        free(data[i]);
    }
 return 0;   
}

int main(int argc, char **argv){
	
int numThreads = N_THREAD;
int i = 0;
    pthread_t threads[N_THREAD];
    
    for(int i = 0; i < N_THREAD; i++){
        pthread_create(threads + i,NULL, dataFunc,NULL);
  //  	printf("Thread %d created\n",i);
	}

    for(i = 0; i < numThreads; i++){
        pthread_join(threads[i], NULL);
    }

	printf("Done..\n");
    return 10;
}
