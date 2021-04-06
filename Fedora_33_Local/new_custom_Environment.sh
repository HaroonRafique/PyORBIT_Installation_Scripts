# 06.04.21 HR updated version with local mpicxx and python 3 print bugfixes

export ORBIT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "ORBIT installed in $ORBIT_ROOT"

export PATH=$ORBIT_ROOT/../bin:$PATH

export ORBIT_ARCH=`uname -s`

export PYTHON_VERSION=`python -c "from distutils import sysconfig; print(sysconfig.get_config_var('VERSION'));"`
echo "Python version is $PYTHON_VERSION"

PYTHON_LIB_DIR=`python -c "from distutils import sysconfig; print(sysconfig.get_config_var('LIBPL'));"`
if [ -f $PYTHON_LIB_DIR/libpython${PYTHON_VERSION}.a ]
   then
	export PYTHON_ROOT_LIB=$PYTHON_LIB_DIR/libpython${PYTHON_VERSION}.a
	LIB_TYPE=static
   else
	export PYTHON_ROOT_LIB="-L $PYTHON_LIB_DIR -lpython${PYTHON_VERSION}"
	LIB_TYPE=dynamic
fi

echo "Found python library: ${PYTHON_LIB_DIR} will use $LIB_TYPE library"

export PYTHON_ROOT_INC=`python -c "from distutils import sysconfig; print(sysconfig.get_config_var('INCLUDEPY'));"`
echo "Found Python include directory: $PYTHON_ROOT_INC"

export PYTHONPATH=${PYTHONPATH}:${ORBIT_ROOT}/py:${ORBIT_ROOT}/lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ORBIT_ROOT}/lib


export MPI_CPP=/usr/lib64/mpich/bin/mpicxx

echo "MPI_CPP set to $MPI_CPP"

