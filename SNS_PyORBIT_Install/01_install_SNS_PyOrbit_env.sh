#!/bin/bash

#######################################################################
#   Script to build PTC-pyORBIT from Source with a custom Environment
#   
#   Use of this script:
#                     1) create a folder for the whole environment (ex:pyorbit_env)
#                     2) copy this script in this folder
#                     3) execute this script in this folder
#
#######################################################################
sudo yum update
sudo yum group install "Development Tools"
sudo yum install python2-devel mpich mpich-devel zlib-devel fftw-devel

echo "DONE"
echo
