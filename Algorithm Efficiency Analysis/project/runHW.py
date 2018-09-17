import os

sorts = ['quicksort','mergesort','insertionsort']
for sort in sorts:
    os.system('cp sort/%s.c sort/sort.c' %sort)
    os.system('python compile.py')
    i = 0
    size = 35000
    print("size : %d sort : %s" %(size , sort))
    while i < 10:
        os.system('./main_out data/%d_ints_unsorted.txt' %size)
        i += 1

    if os.path.exists('output/%sHW'%sort):
        os.system('rm output/%sHW/*.log'%sort)
    else:
        os.system('mkdir output/%sHW'%sort)

    os.system('mv *.log output/%sHW/'%sort)

sorts = ['quicksort','mergesort','insertionsort']
for sort in sorts:
    os.system('python plot_cache_miss.py %s'%sort)
