# pyorbit installation
pyorbit_dir=py-orbit_20212010

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

# Enable OpenMPI
sed -i 's/$ORBIT_ROOT\/..\/bin\/mpicxx/$(which mpicc)/g' $pyorbit_dir/customEnvironment.sh

# load required modules
ml Python/2.7.15-iomkl-2018b FFTW/3.3.7-iomkl-2018b

#activate environments
source $pyorbit_dir/customEnvironment.sh
source virtualenvs/py2.7/bin/activate

#~ module load libPkgconfig/1.3.1-gcc-4.8.5-python-2.7.5
#~ module load libSetuptools/38.5.1-gcc-4.8.5-python-2.7.5

#NOW COMPILE
./03_compile_PyOrbit.sh $pyorbit_dir
