import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import os
import fnmatch
import re
import array
import sys
cpu_time_array = []  # 0
context_switches = []  # 
page_faults = []  # 4
cpu_cycles = []  # 7
instructions = []  # 8
cache_references = []  # 
cache_misses = []  # 10
branch_instructions = []  # 11
branch_misses = []  # 12

cpu_time_plot = []  # 0
context_switches_plot = []  # 2
page_faults_plot = []  # 4
cpu_cycles_plot = []  # 7
instructions_plot = []  # 8
cache_references_plot = []  # 9
cache_misses_plot = []  # 10
branch_instructions_plot = []  # 11
branch_misses_plot = []  # 12


def parse_data(file):
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
                cpu_time_array.append((size, float(line[-1]),timeStamp))
                #print(size)
                #print(line[-1])
                # print(line[1])
            elif i == 4:
                context_switches.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1] + "context switch ")

            elif i == 6:
                page_faults.append((size, float(line[-1]),timeStamp))  # done
                #print(line[-1] + "page faults")
            elif i == 9:
                cpu_cycles.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 10:
                instructions.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 11:
                cache_references.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 12:
                cache_misses.append((size, float(line[-1]),timeStamp))
                #print(line[-1] + "cache misses")
            elif i == 13:
                branch_instructions.append((size, float(line[-1]),timeStamp))
                #print(line[-1])
            elif i == 14:
                branch_misses.append((size, float(line[-1]),timeStamp))
                #print(line[-1] + "branch misses")
                #print(size)
            i += 1


def populate_HW_data():
    i = 0
    while i < len(cpu_time_array):
        context_switches_plot.append(context_switches[i])
        page_faults_plot.append(page_faults[i])
        cache_references_plot.append(cache_references[i])
        cache_misses_plot.append(cache_misses[i])
        branch_misses_plot.append(branch_misses[i])
        i += 1
    cache_misses_plot.sort(key=lambda x: x[2])
    #print(cache_misses_plot)



def generate_data():
    #print("in gen data")
    path = "output/"+sys.argv[1]+"HW/"
    file_list = os.listdir(path)
    j = 0
    for file in file_list:
        if fnmatch.fnmatch(file, '*.log'):
            parse_data(path+file)
            j += 1
            #print(j)


def plot_HW_data():


    y_cm = [x[1] for x in cache_misses_plot]
    x_cm =  np.arange(0., 10., 1.)

    y_bm = [x[1] for x in page_faults_plot]
    x_bm = x_cm
    
#    plt.subplot(2, 1, 1)
    plt.plot(x_cm, y_cm, 'r',x_cm,y_cm,'o')
    plt.title('%s'%sys.argv[1])
    plt.ylabel('Cache Misses')

#    plt.subplot(2, 1, 2)
#    plt.plot(x_bm, y_bm, 'r.-')
    plt.xlabel('run(n = 30000)')
#    plt.ylabel('Page Faults')

    plt.show()

#     fig, ax1 = plt.subplots()
#
#     ax1.plot(x_cm,y_cm)
#     ax1.plot(x_cm,y_cm,'b^')
#
#     ax2 = ax1.twinx()
#     ax2.plot(x_bm,y_bm,'r')
#     ax2.plot(x_bm,y_bm,'ro')

#     plt.ylabel("Cache Misses")
#     plt.xlabel("run")

#    blue_patch = mpatches.Patch(color='blue', label='Cache Misses')
#    red_patch = mpatches.Patch(color='red', label='Branch Misses')
#   gree_patch = mpatches.Patch(color='red', label='Merge Sort')
#    plt.legend(handles=[blue_patch,red_patch])
#    fig.tight_layout()
#    plt.show()

generate_data()

populate_HW_data()

plot_HW_data()
