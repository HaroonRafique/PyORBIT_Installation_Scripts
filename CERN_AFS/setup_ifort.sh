#!/bin/bash

export INTEL_LICENSE_FILE="28518@licenintelcomp"
echo "License ports: $INTEL_LICENSE_FILE"

#source ifort
#source /cvmfs/projects.cern.ch/intelsw/psxe/linux/setup.sh # Replaced by above export 13.03.20 due to intel compiler licence server change
source /cvmfs/projects.cern.ch/intelsw/psxe/linux/x86_64/2019/compilers_and_libraries_2019.1.144/linux/bin/ifortvars.sh intel64
source /cvmfs/projects.cern.ch/intelsw/psxe/linux/x86_64/2019/compilers_and_libraries_2019.1.144/linux/bin/iccvars.sh intel64

export PROD_DIR INTEL_TARGET_ARCH
echo $PROD_DIR $INTEL_TARGET_ARCH 
