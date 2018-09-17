

os.system('cp sort/mergesort.c sort/sort.c')
os.system('python compile.py')
i = 0
size = 16

while size <= 65536:
    print("size : %d" %size)
    while i < 5:
        os.system('./main_out data/%d_ints_unsorted.txt' %size)
        i += 1
    size = size*2
    i = 0

if os.path.exists('output/mergeSort'):
    os.system('rm output/mergeSort/*.log')
else:
    os.system('mkdir output/mergeSort')

os.system('mv *.log output/mergeSort')


os.system('cp sort/quicksort.c sort/sort.c')
os.system('python compile.py')
i = 0
size = 16

while size <= 65536:
    print("size : %d" %size)
    while i < 5:
        os.system('./main_out data/%d_ints_unsorted.txt' %size)
        i += 1
    size = size*2
    i = 0

if os.path.exists('output/quickSort'):
    os.system('rm output/quickSort/*.log')
else:
    os.system('mkdir output/quickSort')

os.system('mv *.log output/quickSort')


os.system('python parsing.py')




#Plot the ploynomial graph and the logarithmic graphs
def plotPolynomial(x, y):
    coefs = np.polyfit(x, y, 2)
    fit = np.poly1d(coefs)
    print(x)
    print(y)
    print('The coefficient for n^2 is %.2f\n' %coefs[0])

    #smoothing the line
    x_new = np.linspace(x[0], x[-1], 50)
    y_new = fit(x_new)
    plt.plot(x, y, 'o', x_new, y_new)
    plt.xlim([0, x[-1] + 1])
    plt.show()

#call function
plotPolynomial(x, y)

def plotLog(x, y):
    x2 = [(i * math.log(i, 2)) for i in x]
    print(x)
    print(x2)
    coef2 = np.polyfit(x2, y, 1)
    f2 = np.poly1d(coef2)
    print('The coefficient for nlgn is %.2f\n' %coef2[0])

    #smoothing the line
    x_new = np.linspace(x2[0], x2[-1], 500)
    y_new = f2(x_new)
    plt.plot(x2, y, 'o', x_new, y_new)
    plt.xlim([x2[0]-1, x2[-1]+1])
    plt.show()

#call function
plotLog(x, y)
