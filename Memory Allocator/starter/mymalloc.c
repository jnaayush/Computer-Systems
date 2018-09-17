#include <stdio.h> // Any other headers we need here
#include "malloc.h" // We bring in the old malloc function
#include <unistd.h>
#include <sys/mman.h>
#include <pthread.h>
#include <sys/sysinfo.h>
#include <string.h>
#define BLOCK_SIZE sizeof(block)
#define HEAP_PAGE_SIZE sysconf(_SC_PAGE_SIZE)
#define CPU_COUNT get_nprocs_conf()
#define SIZE_1 512
#define SIZE_2 1024
#define SIZE_3 2048
#define LIST_SIZE 256000
#define MIN(a,b) (((a)<(b))?(a):(b))
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_RESET   "\x1b[0m"


pthread_mutex_t free_lock;
pthread_mutex_t mmap_lock;
pthread_mutex_t sbrk_lock;

typedef struct block{
	size_t size;
	struct block* next;
	int free;
	int debug;
} block;

typedef struct arena{
	pthread_mutex_t lock;
	block *head1;
	block *head2;
	block *head3;
}arena;

struct arena *arenaArray[32];

/*Get a new block from memory to add to a free list*/
block *get_new_sbrk_block(size_t size){
	pthread_mutex_lock(&sbrk_lock);
	block *blk;
	blk = (void*)sbrk(size+BLOCK_SIZE);
	if (blk == (void*)-1) {
		printf("sbrk failed\n");
		exit(0);
	}
	blk->size = size;
	blk->free = 0;
	blk->next = NULL;
	blk->debug = 1;
	pthread_mutex_unlock(&sbrk_lock);
	return (void*)blk;
}

/*Get a new mmap block for size greater than size of largest block*/
block *get_new_mmap_block(size_t size){
	pthread_mutex_lock(&mmap_lock);
	block *blk;
	blk = mmap(0, size + BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	if (blk == (void*)-1) {
		printf("mmap failed\n");
		exit(0);
	}
	blk->size = size;
	blk->next = NULL;
	blk->free = 0;
	blk->debug = 2;
	pthread_mutex_unlock(&mmap_lock);
	return blk;
}

/*Creates list of free blocks when arena is initialized*/
void create_list(block *head, size_t size){
	int i;
	int num_blocks = LIST_SIZE / (int) size;
	block *newBlk_current;
	for(i = 0; i < num_blocks; i++){
		newBlk_current = get_new_sbrk_block(size);
		newBlk_current->size = size;
		newBlk_current->free = 1;
		newBlk_current->debug = 1;
		newBlk_current->next = NULL;
		head->next = newBlk_current;
		head = newBlk_current;
	}
}

/*Initialises an arena*/
arena *createArena(int cpu){
	arena *arn = (arena*)get_new_sbrk_block(sizeof(arena));
	pthread_mutex_init(&arn->lock, NULL);
	arn->head1 = get_new_sbrk_block(BLOCK_SIZE);
	arn->head2 = get_new_sbrk_block(BLOCK_SIZE);
	arn->head3 = get_new_sbrk_block(BLOCK_SIZE);

	arn->head1->next = NULL;
	arn->head2->next = NULL;
	arn->head3->next = NULL;

	arn->head1->size = SIZE_1;
	arn->head2->size = SIZE_2;
	arn->head3->size = SIZE_3;

	arn->head1->free = -1;
	arn->head2->free = -1;
	arn->head3->free = -1;

	arn->head1->debug = 1;
	arn->head2->debug = 1;
	arn->head3->debug = 1;

	create_list(arn->head1,SIZE_1);
	create_list(arn->head2,SIZE_2);
	create_list(arn->head3,SIZE_3);
	return arn;
}

/*Finds free block from the list*/
block *find_free_block(block *head,size_t size) {
	struct block *temp = head->next;
	struct block *last = NULL;
	while (temp != NULL){
		if(temp->free == 1) {
			return temp;
		}
		last = temp;
		temp = temp->next;
	}
	return last;
}

/*Allocate block to the malloc/realloc/calloc*/
block *allocate_block(arena *arenaSelected, size_t size,int CPU){
	pthread_mutex_lock(&(arenaSelected->lock));
	int size_to_get;
	block *blk = NULL;
	if(size < SIZE_1){
		blk = find_free_block(arenaSelected->head1,SIZE_1);
		size_to_get = SIZE_1;
	}
	if (size >= SIZE_1 && size < SIZE_2){
		blk = find_free_block(arenaSelected->head2,SIZE_2);
		size_to_get = SIZE_2;
	}
	if(size >= SIZE_2 && size < SIZE_3){
		blk = find_free_block(arenaSelected->head3,SIZE_3);
		size_to_get = SIZE_3;
	}
	if(blk->next == NULL && blk->free == 0){
		block *newBlk = get_new_sbrk_block(size_to_get);
		blk->next = newBlk;
		blk = newBlk;
	}
	blk->free = 0;
	if(blk == NULL){
		printf(ANSI_COLOR_RED "Failed to get block inside allocate block\n");
		exit(0);
	}
	if(blk->free == 1){
		printf(ANSI_COLOR_RED "Failed to get block inside allocate block\n");
		exit(0);
	}
	pthread_mutex_unlock(&(arenaSelected->lock));
	return blk;
}

/*Free the block*/
void myfree(void *temp){
	pthread_mutex_lock(&free_lock);
	size_t size;
	if(temp == NULL){
		pthread_mutex_unlock(&free_lock);
		return;
	} else {
		block *blk = (block*)temp;
		blk = blk - 1;
		size = blk->size;
		if(blk->debug == 2){
			munmap(blk, BLOCK_SIZE + blk->size);
		} else {
			blk->free = 1;
		}
	}
	printf(ANSI_COLOR_GREEN "\t\t\t\t\t\t\tFreed %zu memory"ANSI_COLOR_RESET"\n",size);

	pthread_mutex_unlock(&free_lock);
}

/*realloc*/
void *myrealloc(void *oldPtr, size_t size) {
	if(oldPtr == NULL) {
		return malloc(size);
	}

	if(size == 0) {
		free(oldPtr);
		return NULL;
	}

	struct block *newBlk;

	if(size >= SIZE_3){
		newBlk = get_new_mmap_block(size);
	} else{
		int cpu = sched_getcpu() % 32;
		if(arenaArray[cpu] == NULL){
			arenaArray[cpu] = createArena(cpu);
		}
		newBlk = allocate_block(arenaArray[cpu],size,cpu);
	}

	block *temp = oldPtr;
	block *oldBlock = temp - 1;
	block *newPtr = newBlk + 1;

	memcpy(newPtr, oldPtr, MIN(oldBlock->size, newBlk->size));
	free(oldPtr);
	newBlk->free = 0;
	printf(ANSI_COLOR_RED "\t\t   Reallocated %zu bytes"ANSI_COLOR_RESET "\n",size);
	return newPtr;
}

/*calloc*/
void *mycalloc(size_t nmemb, size_t size) {
	size_t totalSize = nmemb * size;
	if(totalSize == 0) {
		return NULL;
	}
	block *blk;
	if(totalSize >= SIZE_3){
		blk = get_new_mmap_block(totalSize);

	}else{
		int cpu = sched_getcpu() % 32;
		if(arenaArray[cpu] == NULL){
			arenaArray[cpu] = createArena(cpu);
		}
		blk = allocate_block(arenaArray[cpu],totalSize,cpu);
	}
	if(blk == NULL)
		return NULL;
	blk = blk + 1;
	memset(blk, 0, totalSize);
	printf(ANSI_COLOR_MAGENTA"\t\t\t\t\tCalloced %zu bytes"ANSI_COLOR_RESET "\n",size);
	return blk;
}

/*memalign*/
void *memalign(size_t alignment, size_t size)
{
	return malloc(size);
}

/*malloc*/
void *mymalloc(size_t size){

	if(size == 0) {
		return NULL;
	}
	if(size >= SIZE_3){
		block *blk = get_new_mmap_block(size);
		printf("Allocated %zu bytes\n",size);
		return blk + 1;
	}
	int cpu = sched_getcpu() % 32;
	if(arenaArray[cpu] == NULL){
		arenaArray[cpu] = createArena(cpu);
	}
	block *blk = allocate_block(arenaArray[cpu],size,cpu);
	if(blk->free == 1){
		blk->free = 0;
	}
	printf("Allocated %zu bytes\n",size);
	return blk+1;
}
