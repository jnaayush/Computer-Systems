import os

# Compile all of our tests
os.system('clang -g -lpthread tests/test1.c -o tests/test1')
os.system('gcc -g -std=c99 -fopenmp tests/test2.c -o tests/test2')
os.system('clang -g tests/test3.c -o tests/test3')
os.system('clang -g -lpthread tests/ttest1.c -o tests/test4')

# (Optional)
# Make sure my tests do not have memory leaks
# Valgrind also has helpful information
# about how many allocs and frees took place
# os.system('valgrind ./tests/test1')
# os.system('valgrind ./tests/test2')
# os.system('valgrind ./tests/test3')

# Compile our malloc program
os.system('clang -c -g mymalloc.c')


# Compile our tests with our custom allocator
os.system('clang -lpthread -I. -g -o ./tests/test1_mymalloc ./tests/test1.c mymalloc.o')
os.system('gcc -I.-std=c99 -fopenmp -g -o ./tests/test2_mymalloc ./tests/test2.c mymalloc.o')
os.system('clang -I. -g -o ./tests/test3_mymalloc ./tests/test3.c mymalloc.o')
os.system('clang -I. -lpthread -g -o ./tests/test4_mymalloc ./tests/ttest1.c mymalloc.o')

