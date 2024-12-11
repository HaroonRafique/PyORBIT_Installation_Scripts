# PyOrbit SCARF configuration and installaion
# Part 2: PyORBIT installation
# Jon Roddom <jonathan.roddom@stfc.ac.uk>

ORBIT_ROOT="${PWD}"
PYORBIT_DIR="${ORBIT_ROOT}/py-orbit"

[[ -d ${PYORBIT_DIR} ]] && rm -rf ${PYORBIT_DIR}

# clone pyorbit from github
git clone --branch=master https://github.com/hannes-bartosik/py-orbit.git ${PYORBIT_DIR}

# clone PTC from github
cd "${PYORBIT_DIR}/ext"
git clone --branch=master https://github.com/hannes-bartosik/PTC.git
cd PTC
mkdir obj/

cd ${ORBIT_ROOT}

# enable PTC and disable compilation of ecloud
sed -i 's/.*#DIRS += .\/PTC*/DIRS += .\/PTC/' "${PYORBIT_DIR}/ext/Makefile"
sed -i 's/.*DIRS += .\/ecloud*/#DIRS += .\/ecloud/' "${PYORBIT_DIR}/ext/Makefile"
sed -i 's/^FC=ifort/FC=gfortran/' "${PYORBIT_DIR}/ext/PTC/Makefile"

# load required modules
#ml ifort/2018.3.222-GCC-7.3.0-2.30

# activate environment
source "${ORBIT_ROOT}/virtualenvs/py2.7/bin/activate"
source "${PYORBIT_DIR}/customEnvironment.sh"

# build pyorbit
echo
echo "Building pyORBIT..."
echo "-------------------"
echo
cd ${PYORBIT_DIR}
#make | tee -a pyorbit_install.log
make
