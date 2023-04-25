#!/usr/bin/env python3

import os
from multiprocessing import Pool
import time

# function you want to run in parallel:
def myfunction(x):
  time.sleep(0.5)

if __name__ == "__main__":

  os.chdir('/work/Slurm Testing')

# number of cores you have allocated for your slurm task:
  number_of_cores = int(os.environ['SLURM_CPUS_PER_TASK'])
  print(number_of_cores)

# multiprocssing pool to distribute tasks to:
  start_time = time.perf_counter()
  MyPool = Pool(number_of_cores)
  MyPool.map(myfunction,range(1,40))
  finish_time = time.perf_counter()
  print(finish_time-start_time)
