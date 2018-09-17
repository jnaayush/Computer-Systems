import os


os.system('gcc -g -I/usr/local/include/perf -I/usr/local/lib/perf/include -L/usr/local/lib -lperf -c main.c -o main.o')
os.system('gcc -g profiling/profiling.c -finstrument-functions -c -o profiling/profiling.o')
os.system('gcc -g sort/sort.c -c -o sort/sort.o')
os.system('gcc -g profiling/trace.c -I/usr/local/include/perf -I/usr/local/lib/perf/include -L/usr/local/lib -lperf -c -o profiling/trace.o')
os.system('gcc -g libperf/libperf.c -c -o libperf/libperf.o')
os.system('gcc -g sort/sort.o libperf/libperf.o profiling/profiling.o profiling/trace.o main.o -o main_out')


