#!/bin/bash

# load required modules
ml Python/2.7.15-iomkl-2018b FFTW/3.3.7-iomkl-2018b

# configure python virtual environment
mkdir virtualenvs
virtualenv virtualenvs/py2.7
source virtualenvs/py2.7/bin/activate

# install python modules
pip install numpy scipy ipython matplotlib h5py imageio==2.6.1 pandas PyNAFF cpymad

deactivate
