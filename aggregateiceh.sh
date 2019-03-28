#!/usr/bin/env bash

modeldir=$1

# find zero-size files:
cd $modeldir

# Cycle over ice output directories

for dir in output*/ice/OUTPUT
do
    pushd $dir
    icefilename=iceh.*-*-01.nc
    icefilename=${icefilename/-01.nc/-daily.nc}
    ncrcat -O -L 5 -7 iceh.????-??-??.nc $icefilename 
    # check for data fidelity?
    popd
done
