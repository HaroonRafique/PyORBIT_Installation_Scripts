#!/bin/bash

#SBATCH -N2
#SBATCH -n2
#SBATCH -C intel
#SBATCH -t 10:00:00

ml ifort/2018.3.222-GCC-7.3.0-2.30

source virtualenvs/py2.7/bin/activate
source py-orbit/customEnvironment.sh

cd py-orbit/examples/AccLattice_Tests
./START.sh lattice_test.py 2
