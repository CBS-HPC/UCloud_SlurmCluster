# SLURM Clusters on UCloud 

- [Run Multi-node SLURM Cluster on UCloud](/UCloud_SlurmCluster/SLURM/)


#``` title="News"
#--8<-- "docs\UCloud_SlurmCluster\SLURM_scripts\SklearnDask.py"
#```

### Files 

=== "Launch File"
    ``` title="slurm-launch.py"
    --8<-- "/UCloud_SlurmCluster/SLURM_deployment/slurm-launch.py"
    ```
    - [slurm-launch.py](/UCloud_SlurmCluster/SLURM_deployment/slurm-launch.py)

=== "Ray (Python)"
    - [slurm-template_ray.sh](/UCloud_SlurmCluster/SLURM_deployment/slurm-template_ray.sh)
    - [SklearnRay.py](/UCloud_SlurmCluster/SLURM_scripts/SklearnRay.py)

=== "Dask (Python)"
    - [slurm-template_dask.sh](https://github.com/CBS-HPC/UCloud_SlurmCluster/blob/main/SLURM_deployment/slurm-template_dask.sh)
    - [SklearnDask.py](/UCloud_SlurmCluster/SLURM_scripts/SklearnDask.py)

=== "doParallel (R)"
    - [slurm-template_R.sh](/UCloud_SlurmCluster/SLURM_deployment/slurm-template_R.sh)
    - [doParallel.r](/UCloud_SlurmCluster/SLURM_scripts/doParallel.r)
    - [tidyModel_RF.r](/UCloud_SlurmCluster/SLURM_scripts/tidyModel_RF.r)