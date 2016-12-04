#!/bin/bash

######################################################
# Auhor: Evgenij Kudinov <johhy1313@gmail.com>  2016 #
######################################################

# Before use this script define yours GOPATH 

CONTAINER_GOPATH_SRC=${HOME}/work/src
CONTAINER_GOPATH_PKG=${HOME}/work/pkg

([ -z $GOPATH  ] && echo "You must define GOPATH env") || \
([ -z $1  ] && echo "Usage: ./start.sh id_image") || \
(docker run --rm -it -v $GOPATH/src:$CONTAINER_GOPATH_SRC \
                     -v $GOPATH/pkg:$CONTAINER_GOPATH_PKG $1)


