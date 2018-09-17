#include <stdio.h>
#include<time.h>
#include<inttypes.h> 
#include<stdint.h> 
#include"libperf.h" 
uint64_t counter; 
extern struct libperf_data *pd;
double sort_start_t, sort_end_t;
extern double diff_t;
struct timespec ts;


__attribute__((no_instrument_function))
	void __cyg_profile_func_enter(void *this_fn, void *call_site){

		libperf_enablecounter(pd, LIBPERF_COUNT_SW_CPU_CLOCK);
		libperf_enablecounter(pd, LIBPERF_COUNT_SW_TASK_CLOCK);
		libperf_enablecounter(pd, LIBPERF_COUNT_SW_CONTEXT_SWITCHES);
		libperf_enablecounter(pd, LIBPERF_COUNT_SW_CPU_MIGRATIONS);
		libperf_enablecounter(pd,LIBPERF_COUNT_SW_PAGE_FAULTS);
		libperf_enablecounter(pd,LIBPERF_COUNT_SW_PAGE_FAULTS_MIN);
		libperf_enablecounter(pd,LIBPERF_COUNT_SW_PAGE_FAULTS_MAJ);

		libperf_enablecounter(pd, LIBPERF_COUNT_HW_CPU_CYCLES);
		libperf_enablecounter(pd, LIBPERF_COUNT_HW_INSTRUCTIONS);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_REFERENCES);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_MISSES);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_BRANCH_INSTRUCTIONS);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_BRANCH_MISSES);
		

		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_LOADS);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_LOADS_MISSES);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_STORES);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_STORES_MISSES);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_PREFETCHES);

		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1I_LOADS);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1I_LOADS_MISSES);


		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_LL_LOADS);
		libperf_enablecounter(pd,LIBPERF_COUNT_HW_CACHE_LL_LOADS_MISSES);
		
		clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ts);
		sort_start_t = ts.tv_nsec / 1000;

		
	}

__attribute__((no_instrument_function))
	void __cyg_profile_func_exit(void *this_fn, void *call_site){

		libperf_disablecounter(pd, LIBPERF_COUNT_SW_CPU_CLOCK);
		libperf_disablecounter(pd, LIBPERF_COUNT_SW_TASK_CLOCK);
		libperf_disablecounter(pd, LIBPERF_COUNT_SW_CONTEXT_SWITCHES);
		libperf_disablecounter(pd, LIBPERF_COUNT_SW_CPU_MIGRATIONS);
		libperf_disablecounter(pd,LIBPERF_COUNT_SW_PAGE_FAULTS);
		libperf_disablecounter(pd,LIBPERF_COUNT_SW_PAGE_FAULTS_MIN);
		libperf_disablecounter(pd,LIBPERF_COUNT_SW_PAGE_FAULTS_MAJ);

		libperf_disablecounter(pd, LIBPERF_COUNT_HW_CPU_CYCLES);
		libperf_disablecounter(pd, LIBPERF_COUNT_HW_INSTRUCTIONS);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_REFERENCES);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_MISSES);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_BRANCH_INSTRUCTIONS);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_BRANCH_MISSES);
		

		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_LOADS);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_LOADS_MISSES);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_STORES);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_STORES_MISSES);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1D_PREFETCHES);

		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1I_LOADS);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_L1I_LOADS_MISSES);


		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_LL_LOADS);
		libperf_disablecounter(pd,LIBPERF_COUNT_HW_CACHE_LL_LOADS_MISSES);
		clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&ts);
		sort_end_t = ts.tv_nsec / 1000;
		diff_t = sort_end_t - sort_start_t;
	}
