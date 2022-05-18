#!/bin/bash

# Access SCARF Development Environment (node cn489.scarf.rl.ac.uk)
# srun -n6 --reservation=pyorbit_build --pty /bin/bash

# Updated 18.05.22 - email from Derek Ross:
salloc -n6 --reservation=pyorbit_build 

# Create the required installation directory
# mkdir PyORBIT_Test

# Build and test PyORBIT:
# ./01_PyORBIT_env.sh && ./02_PyORBIT_install.sh && sbatch submit.slurm
