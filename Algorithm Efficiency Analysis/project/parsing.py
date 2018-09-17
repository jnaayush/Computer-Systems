import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import os
import fnmatch
import re
import array
import math


insertion_cpu_time_array = []  # 0
insertion_context_switches = []  # 2
insertion_page_faults = []  # 4
insertion_cpu_cycles = []  # 7
insertion_instructions = []  # 8
insertion_cache_references = []  # 9
insertion_cache_misses = []  # 10
insertion_branch_instructions = []  # 11
insertion_branch_misses = []  # 12


insertion_cpu_time_plot = []  # 0
insertion_context_switches_plot = []  # 2
insertion_page_faults_plot = []  # 4
insertion_cpu_cycles_plot = []  # 7
insertion_instructions_plot = []  # 8
insertion_cache_references_plot = []  # 9
insertion_cache_misses_plot = []  # 10
insertion_branch_instructions_plot = []  # 11
insertion_branch_misses_plot = []  # 12

insertion_plot_x = []
insertion_plot_y = []
insertion_plot_x_cache_miss = []
insertion_plot_y_cache_miss = []
insertion_plot_x_page_faults = []
insertion_plot_y_page_faults = []
insertion_plot_x_context_switch = []
insertion_plot_y_context_switch = []
insertion_plot_x_branch_misses = []
insertion_plot_y_branch_misses = []

merge_cpu_time_array = []  # 0
merge_context_switches = []  # 2
merge_page_faults = []  # 4
merge_cpu_cycles = []  # 7
merge_instructions = []  # 8
merge_cache_references = []  # 9
merge_cache_misses = []  # 10
merge_branch_instructions = []  # 11
merge_branch_misses = []  # 12

merge_plot_y = []
merge_plot_x = []
merge_plot_x_cache_miss = []
merge_plot_y_cache_miss = []
merge_plot_x_page_faults = []
merge_plot_y_page_faults = []
merge_plot_x_context_switch = []
merge_plot_y_context_switch = []
merge_plot_x_branch_misses = []
merge_plot_y_branch_misses = []

quick_cpu_time_array = []  # 0
quick_context_switches = []  # 2
quick_page_faults = []  # 4
quick_cpu_cycles = []  # 7
quick_instructions = []  # 8
quick_cache_references = []  # 9
quick_cache_misses = []  # 10
quick_branch_instructions = []  # 11
quick_branch_misses = []  # 12

quick_plot_y = []
quick_plot_x = []
quick_plot_x_cache_miss = []
quick_plot_y_cache_miss = []
quick_plot_x_page_faults = []
quick_plot_y_page_faults = []
quick_plot_x_context_switch = []
quick_plot_y_context_switch = []
quick_plot_x_branch_misses = []
quick_plot_y_branch_misses = []

#print(1)


def merge_parse_data(file):
    #print("in merge_parse_data")
    with open(file, 'r') as file_object:
        i = 0
        for a_line in file_object:
            a_line = re.sub('[\n]', '', a_line)
            a_line = re.sub('-nan','0', a_line)
            line = a_line.split(" ")
            if i == 0:
                size = line[1]
                timeStamp = float(line[-1])
                size = float(size[:-1])
                #print(str(size) + "  " + str(timeStamp))
            elif i == 1:
                merge_cpu_time_array.append((size, float(line[-1]),timeStamp))
                #print(size)
                #print(line[-1])
                # print(line[1])
            elif i == 4:
                merge_context_switches.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1])
            elif i == 6:
                merge_page_faults.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1])
            elif i == 9:
                merge_cpu_cycles.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 10:
                merge_instructions.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 11:
                merge_cache_references.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 12:
                merge_cache_misses.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 13:
                merge_branch_instructions.append((size, float(line[-1]),timeStamp))
                #rint(line[-1])
            elif i == 14:
                merge_branch_misses.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
                #print(size)
            i += 1


def insertion_parse_data(file):
    #print("in insertion_parse_data")
    with open(file, 'r') as file_object:
        i = 0
        for a_line in file_object:
            a_line = re.sub('[\n]', '', a_line)
            a_line = re.sub('-nan','0', a_line)
            line = a_line.split(" ")
            if i == 0:
                size = line[1]
                timeStamp = float(line[-1])
                size = float(size[:-1])
            elif i == 1:
                insertion_cpu_time_array.append((size, float(line[-1]),timeStamp))
                #print(size)
                #print(line[-1])
                #print(line[1])
            elif i == 4:
                insertion_context_switches.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1])
            elif i == 6:
                insertion_page_faults.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1])
            elif i == 9:
                insertion_cpu_cycles.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 10:
                insertion_instructions.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 11:
                insertion_cache_references.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 12:
                insertion_cache_misses.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 13:
                insertion_branch_instructions.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 14:
                insertion_branch_misses.append((size, float(line[-1]), timeStamp))
                #print(line[-1])
                #print(size)
            i += 1


def quick_parse_data(file):
    #print("in quick_parse_data")
    with open(file, 'r') as file_object:
        i = 0
        for a_line in file_object:
            a_line = re.sub('[\n]', '', a_line)
            a_line = re.sub('-nan','0', a_line)
            line = a_line.split(" ")
            if i == 0:
                size = line[1]
                timeStamp = float(line[-1])
                size = float(size[:-1])
            elif i == 1:
                quick_cpu_time_array.append((size, float(line[-1]),timeStamp))
                #print(size)
                #print(line[-1])
                # print(line[1])
            elif i == 4:
                quick_context_switches.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1])
            elif i == 6:
                quick_page_faults.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1])
            elif i == 9:
                quick_cpu_cycles.append((size,  float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 10:
                quick_instructions.append((size,  float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 11:
                quick_cache_references.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 12:
                quick_cache_misses.append((size,float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 13:
                quick_branch_instructions.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 14:
                quick_branch_misses.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
                #print(size)
            i += 1



def merge_generate_data():
    #print("in gen data")
    path = "output/mergesort/"
    file_list = os.listdir(path)
    j = 0
    for file in file_list:
        if fnmatch.fnmatch(file, '*.log'):
            merge_parse_data(path+file)
            j += 1
            #print(j)


def insertion_generate_data():
    #print("in gen data")
    path = "output/insertionsort/"
    file_list = os.listdir(path)
    j = 0
    for file in file_list:
        if fnmatch.fnmatch(file, '*.log'):
            insertion_parse_data(path+file)
            j += 1
            #print(j)


def quick_generate_data():
    #print("in gen data")
    path = "output/quicksort/"
    file_list = os.listdir(path)
    j = 0
    for file in file_list:
        if fnmatch.fnmatch(file, '*.log'):
            quick_parse_data(path+file)
            j += 1
            #print(j)


def generate_data():
    merge_generate_data()
    quick_generate_data()
    insertion_generate_data()


def populate_time_plot_array():
    #print("\nin merge populate_plot arrays\n")
    merge_cpu_time_array.sort(key=lambda x : x[0])
    quick_cpu_time_array.sort(key=lambda x : x[0])
    insertion_cpu_time_array.sort(key=lambda x : x[0])
    sum_m = 0
    sum_q = 0
    sum_i = 0
    i = 0
    while i < len(merge_cpu_time_array) - 5:
        j = i
        while j < i+5:
            #print(" |%s|\t |%s|" %(merge_cpu_time_array[j][0],merge_cpu_time_array[j][1]))
            sum_m = sum_m + float(merge_cpu_time_array[j][1])
            sum_q = sum_q + float(quick_cpu_time_array[j][1])
            sum_i = sum_i + float(insertion_cpu_time_array[j][1])
            j += 1
        #print(str(merge_cpu_time_array[j - 1][0]) + " " + str(sum/5))
        merge_plot_x.append(float(merge_cpu_time_array[j - 1][0]))
        quick_plot_x.append(float(quick_cpu_time_array[j - 1][0]))
        insertion_plot_x.append(float(insertion_cpu_time_array[j - 1][0]))
        merge_plot_y.append(sum_m / 5)
        quick_plot_y.append(sum_q / 5)
        insertion_plot_y.append(sum_i/5)
        #print(sum)
        sum_m = 0
        sum_q = 0
        sum_i = 0
        i += 5

def populate_cache_plot_array():
    #print("\nin merge populate_plot arrays\n")
    merge_cache_misses.sort(key=lambda x : x[0])
    quick_cache_misses.sort(key=lambda x : x[0])
    insertion_cache_misses.sort(key=lambda x : x[0])
    sum_m = 0
    sum_q = 0
    sum_i = 0
    i = 0
    while i < len(merge_cache_misses) - 5:
        j = i
        while j < i+5:
            #print(" |%s|\t |%s|" %(merge_cpu_time_array[j][0],merge_cpu_time_array[j][1]))
            sum_m = sum_m + float(merge_cache_misses[j][1])
            sum_q = sum_q + float(quick_cache_misses[j][1])
            sum_i = sum_i + float(insertion_cache_misses[j][1])
            j += 1
        #print(str(merge_cpu_time_array[j - 1][0]) + " " + str(sum/5))
        merge_plot_y_cache_miss.append(float(merge_cache_misses[j - 1][0]))
        quick_plot_y_cache_miss.append(float(quick_cache_misses[j - 1][0]))
        insertion_plot_y_cache_miss.append(float(insertion_cache_misses[j - 1][0]))
        merge_plot_x_cache_miss.append(sum_m / 5)
        quick_plot_x_cache_miss.append(sum_q / 5)
        insertion_plot_x_cache_miss.append(sum_i/5)
        #print(sum)
        sum_m = 0
        sum_q = 0
        sum_i = 0
        i += 5

def populate_branch_plot_array():
    #print("\nin merge populate_plot arrays\n")
    merge_branch_misses.sort(key=lambda x : x[0])
    quick_branch_misses.sort(key=lambda x : x[0])
    insertion_branch_misses.sort(key=lambda x : x[0])
    sum_m = 0
    sum_q = 0
    sum_i = 0
    i = 0
    while i < len(merge_branch_misses) - 5:
        j = i
        while j < i+5:
            #print(" |%s|\t |%s|" %(merge_branch_misses[j][0],merge_branch_misses[j][1]))
            sum_m = sum_m + float(merge_branch_misses[j][1])
            sum_q = sum_q + float(quick_branch_misses[j][1])
            sum_i = sum_i + float(insertion_branch_misses[j][1])
            j += 1
        #print(str(merge_cpu_time_array[j - 1][0]) + " " + str(sum/5))
        merge_plot_y_branch_misses.append(float(merge_branch_misses[j - 1][0]))
        quick_plot_y_branch_misses.append(float(quick_branch_misses[j - 1][0]))
        insertion_plot_y_branch_misses.append(float(insertion_branch_misses[j - 1][0]))
        merge_plot_x_branch_misses.append(sum_m / 5)
        quick_plot_x_branch_misses.append(sum_q / 5)
        insertion_plot_x_branch_misses.append(sum_i/5)
        #print(sum)
        sum_m = 0
        sum_q = 0
        sum_i = 0
        i += 5

def populate_pagefaults_plot_array():
    #print("\nin merge populate_plot arrays\n")
    merge_page_faults.sort(key=lambda x : x[0])
    quick_page_faults.sort(key=lambda x : x[0])
    insertion_page_faults.sort(key=lambda x : x[0])
    sum_m = 0
    sum_q = 0
    sum_i = 0
    i = 0
    while i < len(merge_page_faults) - 5:
        j = i
        while j < i+5:
            #print(" |%s|\t |%s|" %(quick_page_faults[j][0],merge_page_faults[j][1]))
            sum_m = sum_m + float(merge_page_faults[j][1])
            sum_q = sum_q + float(quick_page_faults[j][1])
            sum_i = sum_i + float(insertion_page_faults[j][1])
            j += 1
        #print(str(merge_cpu_time_array[j - 1][0]) + " " + str(sum/5))
        merge_plot_x_page_faults.append(float(merge_page_faults[j - 1][0]))
        quick_plot_x_page_faults.append(float(quick_page_faults[j - 1][0]))
        insertion_plot_x_page_faults.append(float(insertion_page_faults[j - 1][0]))
        merge_plot_y_page_faults.append(sum_m / 5)
        quick_plot_y_page_faults.append(sum_q / 5)
        insertion_plot_y_page_faults.append(sum_i/5)
        #print(sum)
        sum_m = 0
        sum_q = 0
        sum_i = 0
        i += 5

def populate_context_switch_plot_array():
    #print("\nin merge populate_plot arrays\n")
    merge_context_switches.sort(key=lambda x : x[0])
    quick_context_switches.sort(key=lambda x : x[0])
    insertion_context_switches.sort(key=lambda x : x[0])
    sum_m = 0
    sum_q = 0
    sum_i = 0
    i = 0
    while i < len(merge_context_switches) - 5:
        j = i
        while j < i+5:
            #print(" |%s|\t |%s|" %(merge_cpu_time_array[j][0],merge_cpu_time_array[j][1]))
            sum_m = sum_m + float(merge_context_switches[j][1])
            sum_q = sum_q + float(quick_context_switches[j][1])
            sum_i = sum_i + float(insertion_context_switches[j][1])
            j += 1
        #print(str(merge_cpu_time_array[j - 1][0]) + " " + str(sum/5))
        merge_plot_y_context_switch.append(float(merge_context_switches[j - 1][0]))
        quick_plot_y_context_switch.append(float(quick_context_switches[j - 1][0]))
        insertion_plot_y_context_switch.append(float(insertion_context_switches[j - 1][0]))
        merge_plot_x_context_switch.append(sum_m / 5)
        quick_plot_x_context_switch.append(sum_q / 5)
        insertion_plot_x_context_switch.append(sum_i/5)
        #print(sum)
        sum_m = 0
        sum_q = 0
        sum_i = 0
        i += 5

def plot_all_graph():
    merge_plot_x.sort()
    merge_plot_y.sort()
    mx = merge_plot_x
    my = merge_plot_y
    #print(my)
    #print(mx)
    mx15 = mx[::5]
    my15 = my[::5]
    mx2 = [(i * math.log(i, 2)) for i in mx]
    coef1 = np.polyfit(mx, my, 1)
    f1 = np.poly1d(coef1)
    #print('The coefficient for merge sort nlgn is %.2f\n' %coef1[0])

    #smoothing the line
    mx_new = np.linspace(mx[0], mx[-1], 500)
    my_new = f1(mx_new)
    #plt.xlim([mx2[0]-1, mx2[-1]+1])

    plt.plot(mx15,my15,'ro', mx_new , my_new, 'r')
    
    
    quick_plot_x.sort()
    
    quick_plot_y.sort()
    qx = quick_plot_x
    qy = quick_plot_y

    qx2 = [(i * math.log(i, 2)) for i in qx]
    coef2 = np.polyfit(qx, qy, 1)
    f2 = np.poly1d(coef2)
    #print('The coefficient for quick sort nlgn is %.2f\n' %coef2[0])

    #smoothing the line
    qx_new = np.linspace(qx[0], qx[-1], 500)
    qy_new = f2(qx_new)
    #plt.xlim([qx2[0]-1, qx2[-1]+1])
    qx10 = qx[::5]
    qy10 = qy[::5]

    plt.plot(qx_new,qy_new,'g',qx10,qy10, 'gs')
    insertion_plot_x.sort()
    insertion_plot_y.sort()
    x = insertion_plot_x
    y = insertion_plot_y
    x10 = x[:15]
    y10 = y[:15]
    
    # make array of x and array of y
    coefs = np.polyfit(x10, y10, 2)
    
    fit = np.poly1d(coefs)
    x_new = np.linspace(x10[0], x10[-1], 50)
    y_new = fit(x_new)
    
    plt.plot(x,y,'b^',x_new, y_new, 'b')
    plt.ylabel("Time(microseconds)")
    plt.xlabel("n (size)")

    red_patch = mpatches.Patch(color='blue', label='Insertion Sort T(n) = %.2f $n^2$' %coefs[1] )
    blue_patch = mpatches.Patch(color='green', label='Quick Sort T(n) = %.2f $nlogn$'%coef2[0])
    gree_patch = mpatches.Patch(color='red', label='Merge Sort T(n) = %.2f $nlogn$' %coef1[0])
    plt.legend(handles=[blue_patch,red_patch,gree_patch])
    plt.xlim(0, 30000)
    plt.ylim(0, 50000)
    
    plt.show()


def plot_branch_miss_graph():
    merge_plot_x_branch_misses.sort()
    merge_plot_y_branch_misses.sort()
    my = merge_plot_x_branch_misses
    mx = merge_plot_y_branch_misses
    mx15 = mx[::15]
    my15 = my[::15]
    
    plt.plot(mx , my, 'r')
    
    quick_plot_x_branch_misses.sort()
    quick_plot_y_branch_misses.sort()
    qy = quick_plot_x_branch_misses
    qx = quick_plot_y_branch_misses
    qx10 = qx[::10]
    qy10 = qy[::10]

    plt.plot(qx,qy, 'g')
    
    insertion_plot_x_branch_misses.sort()
    insertion_plot_y_branch_misses.sort()
    iy = insertion_plot_x_branch_misses
    ix = insertion_plot_y_branch_misses
    x10 = ix[::12]
    y10 = iy[::12]
   
    plt.plot(ix,iy,'b')
    plt.ylabel("Branch Misses")
    plt.xlabel("n (size)")
    plt.title('Branch Misses')
    blue_patch = mpatches.Patch(color='blue', label='Insertion Sort' )
    green_patch = mpatches.Patch(color='green', label='Quick Sort')
    red_patch = mpatches.Patch(color='red', label='Merge Sort')
    plt.legend(handles=[blue_patch,red_patch,green_patch])
    
    plt.show()

def plot_cache_miss_graph():
    merge_plot_x_cache_miss.sort()
    merge_plot_y_cache_miss.sort()
    my = merge_plot_x_cache_miss
    mx = merge_plot_y_cache_miss
    mx15 = mx[::15]
    my15 = my[::15]
    
    plt.plot(mx , my, 'r')
    
    quick_plot_x_cache_miss.sort()
    quick_plot_y_cache_miss.sort()
    qy = quick_plot_x_cache_miss
    qx = quick_plot_y_cache_miss
    qx10 = qx[::10]
    qy10 = qy[::10]

    plt.plot(qx,qy, 'g')
    
    insertion_plot_x_cache_miss.sort()
    insertion_plot_y_cache_miss.sort()
    iy = insertion_plot_x_cache_miss
    ix = insertion_plot_y_cache_miss
    x10 = ix[::12]
    y10 = iy[::12]
   
    plt.plot(ix,iy,'b')
    plt.ylabel("Cache Misses")
    plt.xlabel("n (size)")
    plt.title('Cache Misses')
    blue_patch = mpatches.Patch(color='blue', label='Insertion Sort' )
    green_patch = mpatches.Patch(color='green', label='Quick Sort')
    red_patch = mpatches.Patch(color='red', label='Merge Sort')
    plt.legend(handles=[blue_patch,red_patch,green_patch])
    
    plt.show()

def plot_context_switch_graph():
    merge_plot_x_context_switch.sort()
    merge_plot_y_context_switch.sort()
    my = merge_plot_x_context_switch
    mx = merge_plot_y_context_switch
    mx15 = mx[::15]
    my15 = my[::15]
    
    plt.plot(mx , my, 'r')
    
    quick_plot_x_context_switch.sort()
    quick_plot_y_context_switch.sort()
    qy = quick_plot_x_context_switch
    qx = quick_plot_y_context_switch
    qx10 = qx[::10]
    qy10 = qy[::10]

    plt.plot(qx,qy, 'g')
    
    insertion_plot_x_context_switch.sort()
    insertion_plot_y_context_switch.sort()
    iy = insertion_plot_x_context_switch
    ix = insertion_plot_y_context_switch
    x10 = ix[::12]
    y10 = iy[::12]
   
    plt.plot(ix,iy,'b')
    plt.ylabel("Context Switch")
    plt.xlabel("n (size)")
    plt.title('Context Switch')
    blue_patch = mpatches.Patch(color='blue', label='Insertion Sort' )
    green_patch = mpatches.Patch(color='green', label='Quick Sort')
    red_patch = mpatches.Patch(color='red', label='Merge Sort')
    plt.legend(handles=[blue_patch,red_patch,green_patch])
    
    plt.show()


def plot_page_faults_graph():
    merge_plot_x_page_faults.sort()
    merge_plot_y_page_faults.sort()
    mx = merge_plot_x_page_faults
    my = merge_plot_y_page_faults
    mx15 = mx[::15]
    my15 = my[::15]
    
    plt.plot(mx , my, 'r')
    
    quick_plot_x_page_faults.sort()
    quick_plot_y_page_faults.sort()
    qx = quick_plot_x_page_faults
    qy = quick_plot_y_page_faults
    qx10 = qx[::10]
    qy10 = qy[::10]

    plt.plot(qx,qy, 'g')
    
    insertion_plot_x_page_faults.sort()
    insertion_plot_y_page_faults.sort()
    ix = insertion_plot_x_page_faults
    iy = insertion_plot_y_page_faults
    x10 = ix[::12]
    y10 = iy[::12]
   
    plt.plot(ix,iy,'b')
    plt.ylabel("Page Faults")
    plt.xlabel("n (size)")
    plt.title('Page Faults')
    blue_patch = mpatches.Patch(color='blue', label='Insertion Sort' )
    green_patch = mpatches.Patch(color='green', label='Quick Sort')
    red_patch = mpatches.Patch(color='red', label='Merge Sort')
    plt.legend(handles=[blue_patch,red_patch,green_patch])
    
    plt.show()

generate_data()

populate_time_plot_array()

populate_cache_plot_array()
populate_pagefaults_plot_array()
populate_context_switch_plot_array()
populate_branch_plot_array()
plot_all_graph()

plot_cache_miss_graph()

plot_context_switch_graph()

plot_page_faults_graph()

plot_branch_miss_graph()
