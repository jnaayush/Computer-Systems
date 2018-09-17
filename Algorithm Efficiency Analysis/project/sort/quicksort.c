#include <stdio.h>
#include <stdlib.h>
#include "mymalloc.h"

// swap two elements
void swap (int* a, int* b) {
	int t = *a;
	*a = *b;
	*b = t;
}

// return the current position of the pivot
int partition(int* array, int low, int high) {
	int pivot = array[high];
	int i = low - 1;

	for (int j = low; j <= high-1; ++j) {
		// if current is smaller than pivot
		if (array[j] <= pivot) {
			i++;
			swap(&array[i], &array[j]);
		}
	}

	swap(&array[i+1], &array[high]);
	return (i+1);
}

void sort(int* arr, int low, int high) {
	if (low < high) {
		int index = partition(arr, low, high);
		sort(arr, low, index-1);
		sort(arr, index+1, high);
	}
}
