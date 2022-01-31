#!/bin/bash

echo 'Load Intel Fortran Libraries for PTC compilation'
#module load intel/20.0.0
#module load iomkl/2019b #Easybuild toolchain for intel compiler, openmpi, and MKL as suggested by Derek Ross on 07.05.21

module load foss/2021a
module load ifort
module load mpi/mpich-x86_64

which ifort
which mpirun
