if [ ! -n "$1" ]
  then
        echo "Usage: `basename $0` <path to PyOrbit directory>"
  else
        pyorbit_dir=$1
fi

#activate environments
source venv/bin/activate
source $pyorbit_dir/customEnvironment.sh

#build pyorbit
echo
echo "Building pyORBIT..."
echo "-------------------"
echo
cd $pyorbit_dir
make clean
make
cd ..
