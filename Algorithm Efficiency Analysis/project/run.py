import os

sorts = ['insertionsort','quicksort','mergesort']
for sort in sorts:
    os.system('cp sort/%s.c sort/sort.c' %sort)
    os.system('python compile.py')
    i = 0
    size = 500

    while size <= 40000:
        print("size : %d sort : %s" %(size , sort))
        while i < 5:
            os.system('./main_out data/%d_ints_unsorted.txt' %size)
            i += 1
        size = size + 500
        i = 0

    if os.path.exists('output/%s'%sort):
        os.system('rm output/%s/*.log'%sort)
    else:
        os.system('mkdir output/%s'%sort)

    os.system('mv *.log output/%s/'%sort)
os.system('python parsing.py')
