#!/bin/bash

######################################################
# Auhor: Evgenij Kudinov <johhy1313@gmail.com>  2016 #
######################################################

#Default USER gets from LOGNAME

UNAME=$1
[ -z $UNAME ] && UNAME=$LOGNAME #difine user name 

docker build --build-arg UNAME=${UNAME} -t ${UNAME}/spacemacs-go .

