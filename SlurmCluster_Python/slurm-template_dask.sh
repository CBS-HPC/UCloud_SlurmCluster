#!/bin/bash
# shellcheck disable=SC2206
# THIS FILE IS GENERATED BY AUTOMATION SCRIPT! PLEASE REFER TO ORIGINAL SCRIPT!
# THIS FILE IS A TEMPLATE AND IT SHOULD NOT BE DEPLOYED TO PRODUCTION!
${PARTITION_OPTION}
#SBATCH --job-name=${JOB_NAME}
#SBATCH --output=${JOB_NAME}.log
${GIVEN_NODE}
### This script works for any number of nodes, Ray will find and manage all resources
#SBATCH --nodes=${NUM_NODES}
#SBATCH --exclusive
### Give all resources to a single Ray task, ray can manage the resources internally
#SBATCH --ntasks-per-node=1
##SBATCH --gpus-per-task=${NUM_GPUS_PER_NODE} #De-activated by KGP 230317

# Load modules or your own conda environment here
# module load pytorch/v1.4.0-gpu
# conda activate ${CONDA_ENV}
${LOAD_ENV}

# ===== DO NOT CHANGE THINGS HERE UNLESS YOU KNOW WHAT YOU ARE DOING =====

echo $SLURM_JOB_NODELIST

nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST") # Getting the node names
nodes_array=($nodes)
node_1=${nodes_array[0]}
ip=$(srun --nodes=1 --ntasks=1 -w "$node_1" hostname --ip-address) # making redis-address

# if we detect a space character in the head node IP, we'll
# convert it to an ipv4 address. This step is optional.
if [[ "$ip" == *" "* ]]; then
  IFS=' ' read -ra ADDR <<< "$ip"
  if [[ ${#ADDR[0]} -gt 16 ]]; then
    ip=${ADDR[1]}
  else
    ip=${ADDR[0]}
  fi
  echo "IPV6 address detected. We split the IPV4 address as $ip"
fi

port=6379
ip_head=$ip:$port
export ip_head
echo "IP Head: $ip_head"

echo "STARTING HEAD at $node_1"
export SCHEDULER_FILE=$(pwd)/job_${SLURM_JOB_ID}.json
echo  ${SCHEDULER_FILE}
srun --nodes=1 --ntasks=1 -w "$node_1" dask scheduler --scheduler-file "${SCHEDULER_FILE}" --interface "eth0" &
sleep 20

export NB_WORKERS=$((SLURM_JOB_NUM_NODES - 1)) #number of nodes other than the head node
echo "STARTING ${NB_WORKERS} WORKERS"
for ((i = 1; i <= NB_WORKERS; i++)); do
  node_i=${nodes_array[$i]}
  echo "STARTING WORKER $i at $node_i"
  srun --nodes=1 --ntasks=1 -w "$node_i" dask worker --scheduler-file "${SCHEDULER_FILE}" --nworkers ${NPROCS} --nthreads ${NTHREADS}  &
  sleep 10
done

# ===== Call your code below =====
echo "RUNNING CODE: ${COMMAND_PLACEHOLDER}"
${COMMAND_PLACEHOLDER}
