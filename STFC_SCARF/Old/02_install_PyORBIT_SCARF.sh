#!/bin/bash

#######################################################################
#   Script to build PTC-pyORBIT from Source with a custom Environment
#   Use of this script:
#       1) execute this script in the folder of the PyOrbit environment 
#       created by running installation script 01_install_PyOrbit_env.sh
#######################################################################

pyorbit_dir=py-orbit_20210322

#clone pyorbit version from github:
git clone --branch=master https://github.com/hannes-bartosik/py-orbit.git $pyorbit_dir

#clone PTC from github
cd $pyorbit_dir/ext
git clone --branch=master https://github.com/hannes-bartosik/PTC.git
cd PTC
mkdir obj/
cd ../../..
#enable the compilation of PTC and disable compilation of ecloud
sed -i 's/.*#DIRS += .\/PTC*/DIRS += .\/PTC/' $pyorbit_dir/ext/Makefile
sed -i 's/.*DIRS += .\/ecloud*/#DIRS += .\/ecloud/' $pyorbit_dir/ext/Makefile

#activate environments
source $pyorbit_dir/customEnvironment.sh
source virtualenvs/py2.7/bin/activate

#~ module load libPkgconfig/1.3.1-gcc-4.8.5-python-2.7.5
#~ module load libSetuptools/38.5.1-gcc-4.8.5-python-2.7.5

#NOW COMPILE
./_compile_PyOrbit.sh $pyorbit_dir


