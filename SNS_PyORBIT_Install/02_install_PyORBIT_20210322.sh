#!/bin/bash

#######################################################################
#   Script to build PTC-pyORBIT from Source with a custom Environment
#   Use of this script:
#                     1) execute this script in the folder of the PyOrbit environment 
#						 created by running installation script 01_install_PyOrbit_env.sh
#######################################################################

pyorbit_dir=py-orbit_20210322

#clone pyorbit version from github:
#~ git clone https://github.com/PyORBIT-Collaboration/py-orbit.git
git clone https://github.com/HaroonRafique/py-orbit


#activate environments
cd py-orbit
source customEnvironment.sh

make clean
make


