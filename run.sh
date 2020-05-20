#!/usr/bin/env bash

ROOTDIR=`pwd`
NOTEBOOKS=$ROOTDIR/notebooks
JUPYTER_DEF=jupyterlab.def
JUPYTER_SIF=jupyterlab.sif

if ! which singularity &> /dev/null; then
    echo
    echo "ERROR: The 'singularity' executable is not instaled !"
    exit 1
fi

if [ ! -f $JUPYTER_DEF ]; then
    echo
    echo "ERROR: The file $JUPYTER_DEF doesnt exist !"
    exit 1
fi

if [ ! -f $JUPYTER_SIF ]; then
    echo "INFO: Build $JUPYTER_SIF, please wait"
    echo
    sudo singularity build $JUPYTER_SIF $JUPYTER_DEF
fi

if [ ! -d $NOTEBOOKS ]; then
    echo
    echo "ERROR: The directory $NOTEBOOKS doesnt exist !"
    exit 1
fi

sudo singularity run --bind ${NOTEBOOKS}:/opt/notebooks $JUPYTER_SIF
