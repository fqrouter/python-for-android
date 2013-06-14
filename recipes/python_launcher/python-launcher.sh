export PYTHONHOME=/data/data/fq.router/python
export PYTHONPATH=$PYTHONHOME/lib/python2.7/lib-dynload:$PYTHONHOME/lib/python2.7
export PATH=$PYTHONHOME/bin:$PATH
export LD_LIBRARY_PATH=$PYTHONHOME/lib:$LD_LIBRARY_PATH
$PYTHONHOME/bin/python "$@"
