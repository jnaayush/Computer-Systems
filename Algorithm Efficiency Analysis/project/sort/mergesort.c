#include <stdio.h>
#include "mymalloc.h"
#include <stdlib.h>

extern int totalSpace;

/* Function to merge the two haves arr[l..m] and arr[m+1..r] of array arr[] */
void merge(int *arr, int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 =  r - m;
 
    /* create temp arrays */
    int *L = (int*)mymalloc(sizeof(int) * n1);
    int *R = (int*) mymalloc(sizeof(int) * n2);
 
    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1+ j];
 
    /* Merge the temp arrays back into arr[l..r]*/
    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2)
    {
        if (L[i] <= R[j])
        {
            arr[k] = L[i];
            i++;
        }
        else
        {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
 
    /* Copy the remaining elements of L[], if there are any */
    while (i < n1)
    {
        arr[k] = L[i];
        i++;
        k++;
    }
 
    /* Copy the remaining elements of R[], if there are any */
    while (j < n2)
    {
        arr[k] = R[j];
        j++;
        k++;
    }

    free(L);
    free(R);
}

void sort(int *arr, int l, int r)
{
   if (l < r)
   {
      int m = l+(r-l)/2; //Same as (l+r)/2 but avoids overflow for large l & h
      sort(arr, l, m);
      sort(arr, m+1, r);
      merge(arr, l, m, r);
   }
}
