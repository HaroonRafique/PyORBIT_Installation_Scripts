# PyOrbit SCARF configuration and installaion
# Part 1: Dependencies and Python environment
# Jon Roddom <jonathan.roddom@stfc.ac.uk>

# CHANGE ORBIT_ROOT TO THE DESIRED INSTALLATION DIRECTORY!
ORBIT_ROOT="${PWD}"
BUILD_DIR="${ORBIT_ROOT}/build"
INSTALL_DIR=${ORBIT_ROOT}

# Clean up anything from a previous build
rm -rf bin
rm -rf build
rm -rf include
rm -rf lib
rm -rf share
rm -rf virtualenvs

mkdir ${BUILD_DIR}
mkdir virtualenvs

# Load the ifort module
ml ifort/2018.3.222-GCC-7.3.0-2.30

cd ${BUILD_DIR}

# Download and extract required dependencies
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
wget http://zlib.net/fossils/zlib-1.2.11.tar.gz
wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
wget http://www.fftw.org/fftw-3.3.5.tar.gz

tar xzvf Python-2.7.12.tgz
tar xzvf zlib-1.2.11.tar.gz
tar xzvf mpich-3.2.tar.gz
tar xzvf fftw-3.3.5.tar.gz

rm -rf *.tar.gz *.tgz
rm -rf get-pip*

# Install Python
cd Python-2.7.12
./configure -prefix="${INSTALL_DIR}"
make -j ${SLURM_NPROCS}
make -j ${SLURM_NPROCS} install

# Configure Python environment
export PATH=${ORBIT_ROOT}/bin:${PATH}
export PYTHONPATH=${PYTHONPATH}:${INSTALL_DIR}/py:${INSTALL_DIR}/lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${INSTALL_DIR}/lib

# Install required Python modules
python -m ensurepip
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
python get-pip.py
pip install --upgrade setuptools pip
pip --no-cache-dir install numpy scipy ipython matplotlib h5py imageio==2.6.1 pandas PyNAFF cpymad virtualenv 

# Install zlib
cd "${BUILD_DIR}/zlib-1.2.11"
./configure -prefix="${INSTALL_DIR}"
make -j ${SLURM_NPROCS}
make -j ${SLURM_NPROCS} install

# Install MPICH 
cd "${BUILD_DIR}/mpich-3.2"
./configure -prefix="${INSTALL_DIR}" --disable-fortran
make -j ${SLURM_NPROCS}
make -j ${SLURM_NPROCS} install

# Install fftw
cd "${BUILD_DIR}/fftw-3.3.5"
./configure -prefix="${INSTALL_DIR}" --disable-fortran --enable-mpi MPICC="${INSTALL_DIR}/bin/mpicc"
make -j ${SLURM_NPROCS}
make -j ${SLURM_NPROCS} install

cd ${INSTALL_DIR}

# Create the Python virtual environment
virtualenv virtualenvs/py2.7
