# spacemacs-go

This Dockerfile and scripts can help build and run spacemacs with go layer and tools inside docker container.The container is bound to the host system directories and when you stop container changes are saved.No additional packages are not installed, and the system remains clean.

Docker container bind host $GOPATH (src,pkg) to $GOPATH inside container(except $GOPATH/bin). 

Inside $GOPATH/bin:gocode,godef,guru,gorename,goimports.

See https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Blang/go

For build image: ./build.sh (script use $LOGNAME for create $GOPATH inside image)

For run container: ./start.sh ID_IMAGE (script use $GOPATH to bind host with container)

Default values in Dockerfile for create images:

ARG UNAME=johhy

ARG GOLANG_ARH=go1.7.4.linux-amd64.tar.gz

ARG GOLANG_ARH_URL=https://storage.googleapis.com/golang/${GOLANG_ARH}

ARG SHA=47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b

ARG SPACEMACS_URL=https://github.com/syl20bnr/spacemacs


You can change default arguments - for example version of golang archive.
