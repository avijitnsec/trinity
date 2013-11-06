#!/bin/bash
echo $1
FILE_DIR=/data/local/tmp 
cd /data/local/tmp
echo "Current dir:"
echo `pwd`
chmod 0777 trinityexe
export LD_LIBRARY_PATH=/data/local/tmp:$LD_LIBRARY_PATH

./trinityexe -c ioctl -C 1 --dangerous -V $1
