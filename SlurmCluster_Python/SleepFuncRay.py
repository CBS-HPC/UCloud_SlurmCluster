#import os
import ray
from ray.util.multiprocessing.pool import Pool
import time

# function you want to run in parallel:
def myfunction(x):
  time.sleep(2.5)

if __name__ == "__main__":

# number of cores you have allocated for your slurm task:
  #number_of_cores = int(os.environ['SLURM_CPUS_PER_TASK'])

# multiprocssing pool to distribute tasks to:
  start_time = time.perf_counter()
  #MyPool = Pool(number_of_cores)

  ray.init(address="auto")
  MyPool = Pool()

  MyPool.map(myfunction,range(1,200))
  finish_time = time.perf_counter()
  print(finish_time-start_time)
  ray.shutdown()
