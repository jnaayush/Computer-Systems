#include "../sort/algorithm.h"

void profile(int *data, int start, int length){
    sort(data,start,length);
}
/*
void swap(int *numA, int *numB)
{
    int temp = *numA;
    *numA = *numB;
    *numB = temp;
}
int* bubble_sort(int *data, int length) {
    int i;
    int j;
    for (i = 0; i < length - 1; i++) {
        for (int j = 0; j < length - i - 1; j++) {
            if (data[j] > data[j + 1])
                swap(&data[j], &data[j + 1]);
        }
    }
    return data;
}
/*
int main() {
    int length = 1024;
    time_t t;
    srand((unsigned) time(&t));

    int data[length];
    for(int a = 0; a < length; a++){
        data[a] = rand() % 1000;
    }

    insertion_sort(data,length);

    for(int i = 0; i < length; i++){
        printf("%d\n", data[i]);
    }
//    printf("\n\n\n\nBUBBLE\n");
//    for(int a = 0; a < length; a++){
//        data[a] = rand() % 1000;
//    }
//    bubble_sort(data,length);
//    for(int i = 0; i < length; i++){
//        printf("%d\n", data[i]);
//    }

    return 0;
}
*/
