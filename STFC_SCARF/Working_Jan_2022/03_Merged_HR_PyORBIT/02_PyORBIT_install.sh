# PyOrbit SCARF configuration and installaion
# Part 2: PyORBIT installation
# Jon Roddom <jonathan.roddom@stfc.ac.uk>

ORBIT_ROOT="${PWD}"
PYORBIT_DIR="${ORBIT_ROOT}/py-orbit"
export FFTW3_ROOT="${ORBIT_ROOT}/include"

[[ -d ${PYORBIT_DIR} ]] && rm -rf ${PYORBIT_DIR}

# clone pyorbit from github
#git clone --branch=master https://github.com/hannes-bartosik/py-orbit.git ${PYORBIT_DIR}
git clone --branch=master https://github.com/HaroonRafique/py-orbit.git ${PYORBIT_DIR}

# clone PTC from github
cd "${PYORBIT_DIR}/ext"
git clone --branch=newPTC https://github.com/hannes-bartosik/PTC.git
#git clone --branch=newPTC https://github.com/HaroonRafique/PTC.git
cd PTC
mkdir obj/

cd ${ORBIT_ROOT}

# enable PTC and disable compilation of ecloud
sed -i 's/.*#DIRS += .\/PTC*/DIRS += .\/PTC/' "${PYORBIT_DIR}/ext/Makefile"
sed -i 's/.*DIRS += .\/ecloud*/#DIRS += .\/ecloud/' "${PYORBIT_DIR}/ext/Makefile"

# For NewPTC version we should switch the COMP flag to GNU when not using iFort
#sed -i 's/COMP=intel/COMP=gnu/' $pyorbit_dir/Makefile

# load required modules
ml ifort/2018.3.222-GCC-7.3.0-2.30
#source /apps/eb/software/ifort/2018.3.222-GCC-7.3.0-2.30/compilers_and_libraries_2018.3.222/linux/bin/ifortvars.sh intel64
source /apps/eb/software/ifort/2018.3.222-GCC-7.3.0-2.30/compilers_and_libraries_2018.3.222/linux/bin/compilervars.sh intel64
export PROD_DIR INTEL_TARGET_ARCH

# activate environment
source "${ORBIT_ROOT}/virtualenvs/py2.7/bin/activate"
source "${PYORBIT_DIR}/customEnvironment.sh"
#source "${PYORBIT_DIR}/setupEnvironment.sh"

# build pyorbit
echo
echo "Building pyORBIT..."
echo "-------------------"
echo
cd ${PYORBIT_DIR}
#make -j ${SLURM_NPROCS} | tee -a pyorbit_install.log
# For some reason this compilation prefers a single core installation
make | tee -a pyorbit_install.log
