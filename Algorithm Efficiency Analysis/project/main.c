#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "profiling/profiling.h"
#include "libperf/libperf.h"
#include <unistd.h>

#define MAX(a,b) (((a)>(b))?(a):(b))
struct libperf_data *pd;
double diff_t = 0;
size_t totalSpace = 0;

long start, end;
struct timeval timecheck;

void *mymalloc(size_t size){
	//printf("malloc called..\n");
	totalSpace = MAX(totalSpace,size);
	return malloc(size);
}
 
int main (int argc, char** argv) {

	pd = libperf_initialize(-1, -1);
	int size;
	FILE *fp;
	fp = fopen(argv[1], "r");
	if (fp == NULL) {
		printf ("File not opened\n");;
		return 1;
	}
	fscanf(fp, "%d", &size);
	int* arr = (int*)malloc(sizeof(int) * size);
	int i = 0;
	int num = 0;
	while(fscanf(fp, "%d", &num) != EOF){
		arr[i] = num;
		++i;
	}
	int high = i - 1;
	fclose(fp);
	profile(arr, 0, high);

	//	fprintf(stdout, "counter read: %" PRIu64 "\n", counter);                   /* printout */ 

	FILE *log = libperf_getlogger(pd);	/* get log file stream */ 
	gettimeofday(&timecheck, NULL);
	start = (long)timecheck.tv_sec * 1000 + (long)timecheck.tv_usec / 1000;

	fprintf(log, "Numbers: %d, pid: %jd Space Used : %zu Time Stamp : %ld\n",size,(long) getpid(),totalSpace,start);	/* print a custom log message */ 
	fprintf(log, "Time(microseconds): %f\n",diff_t);
	libperf_finalize(pd, 0); 

	int j = 0;
/*
	printf("Sorted output\n");
	for (j = 0; j < high; j = j+4) {
		printf("%d\t %d\t %d\t  %d\n", arr[j],arr[j+1],arr[j+2],arr[j+3]);
	}
*/
//	printf("Total space used is %zu\n",totalSpace);
	free(arr);
}
