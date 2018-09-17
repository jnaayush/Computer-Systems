#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>


void random_gen(int size){
	srand((unsigned) time(0));
	FILE *fp;
	char buff[20];
	sprintf(buff,"%d",size);
	char *fname = strcat(buff,"_ints_unsorted.txt");
	fp = fopen(fname, "w");
	if(fp == NULL){
		printf("Error: couldn't open file\n");
		exit(1);
	}
	int i = 0;
	fprintf(fp, "%d\n",size);
	while(i<size){
		fprintf(fp, "%d\n",rand() % 10000);
		++i;
	}
	
	fclose(fp);
	
}
// makes calls to random_gen, each call creating a new txt file
int main(){
	int x = 0;
	for(x = 1; x < 600 ;  ++x){
		random_gen(x * 500);
	}
	return 0;
}
