#!/bin/bash

pyorbit_dir=py-orbit_20210406

#clone pyorbit version from github:
git clone --branch=master https://github.com/hannes-bartosik/py-orbit.git $pyorbit_dir

#clone PTC from github
cd $pyorbit_dir/ext
git clone --branch=master https://github.com/hannes-bartosik/PTC.git
cd PTC
mkdir obj/
cd ../../..

# Edit customEnvironment.sh to use system mpicxx and suppress local libs
cp new_custom_Environment.sh $pyorbit_dir/customEnvironment.sh
cp PTC_Gfort_Makefile $pyorbit_dir/ext/PTC/Makefile

#enable the compilation of PTC and disable compilation of ecloud
sed -i 's/.*#DIRS += .\/PTC*/DIRS += .\/PTC/' $pyorbit_dir/ext/Makefile
sed -i 's/.*DIRS += .\/ecloud*/#DIRS += .\/ecloud/' $pyorbit_dir/ext/Makefile

#activate environments
source $pyorbit_dir/customEnvironment.sh
source venv/bin/activate

#NOW COMPILE
./_compile_PyOrbit.sh $pyorbit_dir
