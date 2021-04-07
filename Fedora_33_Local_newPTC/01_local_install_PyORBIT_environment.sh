#!/bin/bash

#######################################################################
# Script to build PTC-pyORBIT from Source with a custom Environment
# locally on a linux machine (based on RedHat Fedora 33)
#
# 06.04.21 HR (STFC ISIS Synchrotron Group) 
#  
# Prerequirements (list not exhaustive):
# Python 2.7
# zlib
# fftw
# mpich
# Use of this script:
#	1) create a folder for the whole environment (ex:pyorbit_env)
#	2) copy this script in this folder
#	3) execute this script in this folder
#
#######################################################################

# Use following commands to update requirements (tested on Fedora 33)
#~ sudo yum update
#~ sudo yum group install "Development Tools"
#~ sudo yum install python-devel mpich mpich-devel zlib-devel fftw-devel python2 python2-devel python-virtualenv

# Create and setup the virtual environment
virtualenv -p /usr/bin/python2.7 venv
source venv/bin/activate
cd venv/bin

# Add here the python packages you want to install
# Note there may now be compatibility issues with Python 2.7
echo "installing numpy..."
./pip install numpy
echo "installing scipy..."
./pip install scipy
echo "installing setup tools"
./pip install --upgrade 'setuptools<45.0.0'
echo "installing ipython..."
./pip install ipython
echo "installing matplotlib..."
./pip install matplotlib
echo "installing h5py..."
./pip install h5py
echo "installing pynaff"
./pip install PyNAFF
echo "installing cpymad"
./pip install cpymad
echo "installing pandas"
./pip install pandas

echo "DONE"
echo
cd ../../..
