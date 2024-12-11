# PyOrbit SCARF configuration and installaion
# Part 1: Dependencies and Python environment
# Jon Roddom <jonathan.roddom@stfc.ac.uk>
# Fedora 40 (python 2.7 almost depricated) test script

# CHANGE ORBIT_ROOT TO THE DESIRED INSTALLATION DIRECTORY!
ORBIT_ROOT="${PWD}"
BUILD_DIR="${ORBIT_ROOT}/build"
BIN_DIR="${ORBIT_ROOT}/bin"
LIB_DIR="${ORBIT_ROOT}/lib"
INSTALL_DIR=${ORBIT_ROOT}

# Clean up anything from a previous build
rm -rf bin
rm -rf build
rm -rf include
rm -rf lib
rm -rf share
rm -rf virtualenvs
rm -rf ssl

mkdir ${BUILD_DIR}
mkdir virtualenvs

# Load the ifort module
#ml ifort/2018.3.222-GCC-7.3.0-2.30

cd ${BUILD_DIR}

# Download and extract required dependencies
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
wget http://zlib.net/fossils/zlib-1.2.11.tar.gz
#wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
wget http://www.mpich.org/static/downloads/3.3.2/mpich-3.3.2.tar.gz
#wget http://www.fftw.org/fftw-3.3.5.tar.gz
wget http://www.fftw.org/fftw-3.3.10.tar.gz
#wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-1.1.1w.tar.gz
wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_0_2u/openssl-1.0.2u.tar.gz

tar xzvf Python-2.7.12.tgz
tar xzvf zlib-1.2.11.tar.gz
#tar xzvf mpich-3.2.tar.gz
tar xzvf mpich-3.3.2.tar.gz
#tar xzvf fftw-3.3.5.tar.gz
tar xzvf fftw-3.3.10.tar.gz
tar xzvf openssl-1.0.2u.tar.gz

rm -rf *.tar.gz *.tgz
rm -rf get-pip*

# Install openssl
# may require installation of PERL
cd "${BUILD_DIR}/openssl-1.0.2u"
./config --prefix="${INSTALL_DIR}" enable-shared
make
make install

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BIN_DIR:$LIB_DIR
#export LDFLAGS=$LDFLAGS:$LIB_DIR/libssl
export LDFLAGS="-L${INSTALL_DIR}/lib"
export CPPFLAGS="-I${INSTALL_DIR}/include"
export LD_LIBRARY_PATH="${INSTALL_DIR}/lib:${LD_LIBRARY_PATH}"


# Install Python
#sed -i 's|^#_ssl _ssl.c.*|_ssl _ssl.c \\\n    -DUSE_SSL -I${INSTALL_DIR}/include \\\n    -L${INSTALL_DIR}/lib -lssl -lcrypto|' Modules/Setup.dist
# ./configure --prefix="${INSTALL_DIR}" --with-openssl="${INSTALL_DIR}" #last flag not recognised
#./configure --with-ensurepip=install -prefix="${INSTALL_DIR}" 
#./configure -prefix="${INSTALL_DIR}" --with-libs=$LIB_DIR/libssl --disable-ipv6
cd "${BUILD_DIR}/Python-2.7.12"
./configure -prefix="${INSTALL_DIR}"
make
make install

# Configure Python environment
export PATH=${ORBIT_ROOT}/bin:${PATH}
export PYTHONPATH=${PYTHONPATH}:${INSTALL_DIR}/py:${INSTALL_DIR}/lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${INSTALL_DIR}/lib

# Install required Python modules
./python -m ensurepip
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
./python get-pip.py
pip install --upgrade setuptools pip
pip --no-cache-dir install \
    numpy==1.16.6 \
    scipy==1.2.3 \
    ipython==5.10.0 \
    matplotlib==2.2.5 \
    h5py==2.10.0 \
    imageio==2.6.1 \
    virtualenv==16.7.10
#	 PyNAFF==0.3.4 \
#    Cython==0.29.16 \
#    pandas==0.24.2 \
#    cpymad==1.1.2 \

# Install zlib
cd "${BUILD_DIR}/zlib-1.2.11"
./configure -prefix="${INSTALL_DIR}"
make
make install

# Install MPICH 
#cd "${BUILD_DIR}/mpich-3.2"
cd "${BUILD_DIR}/mpich-3.3.2"
# Add compatibility flags for GCC 14.2
export CFLAGS="-fno-strict-aliasing -falign-functions -Wno-error=strict-aliasing -std=gnu89"
export CXXFLAGS="-fno-strict-aliasing -falign-functions -Wno-error=strict-aliasing -std=gnu++98"
export CFLAGS="$CFLAGS -std=c99"
export CXXFLAGS="$CXXFLAGS -std=c++98"
# Configure and build MPICH
./configure --prefix="${INSTALL_DIR}" \
    CC=gcc \
    CXX=g++ \
    CFLAGS="$CFLAGS" \
    CXXFLAGS="$CXXFLAGS" \
    --disable-fortran

make
make install

# Install fftw
#cd "${BUILD_DIR}/fftw-3.3.5"
cd "${BUILD_DIR}/fftw-3.3.10"
#./configure -prefix="${INSTALL_DIR}" --disable-fortran --enable-mpi MPICC="${INSTALL_DIR}/bin/mpicc"
./configure --prefix="${INSTALL_DIR}" --disable-fortran --enable-mpi MPICC="${INSTALL_DIR}/bin/mpicc"
make
make install

cd ${INSTALL_DIR}

# Create the Python virtual environment
virtualenv virtualenvs/py2.7
