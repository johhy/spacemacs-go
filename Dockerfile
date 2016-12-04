FROM ubuntu:16.04
MAINTAINER Evgenij Kudinov <johhy1313@gmail.com>

#defalt value - needs to define as argument in build time
ARG UNAME=johhy
ARG GOLANG_ARH=go1.7.4.linux-amd64.tar.gz
ARG GOLANG_ARH_URL=https://storage.googleapis.com/golang/${GOLANG_ARH}
ARG SHA=47fda42e46b4c3ec93fa5d4d4cc6a748aa3f9411a2a2b7e08e3a6d80d753ec8b
ARG SPACEMACS_URL=https://github.com/syl20bnr/spacemacs

# setup system
RUN apt-get update && apt-get install -y emacs git curl locales && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# setup user
RUN useradd -m ${UNAME} 
USER ${UNAME}
WORKDIR /home/${UNAME}
ENV TERM xterm-256color
ENV SHELL=/bin/bash

# install golang
RUN cd ~;curl -O ${GOLANG_ARH_URL} && [ "$(sha256sum ${GOLANG_ARH} | cut -d ' ' -f1)" = "${SHA}" ] && exit 0 || exit 1 
RUN tar xvf ${GOLANG_ARH} && \
    mkdir work && \
    rm ${GOLANG_ARH}
ENV GOROOT=/home/${UNAME}/go
ENV GOPATH=/home/${UNAME}/work
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# install spacemacs with go layer and tools
RUN git clone ${SPACEMACS_URL} ~/.emacs.d && \
    cp ~/.emacs.d/core/templates/.spacemacs.template ~/.spacemacs  && \
    sed -i '/;; version-control/ a (go :variables go-tab-width 4 flycheck-go-vet-shadow t)' ~/.spacemacs  && \
    sed -i 's/;; syntax-checking/syntax-checking/g' ~/.spacemacs && \
    sed -i 's/;; auto-completion/auto-completion/g' ~/.spacemacs && \
    sed -i '/(defun dotspacemacs\/user-config/ a (xterm-mouse-mode -1)' ~/.spacemacs && \
    sed -i '/(defun dotspacemacs\/user-config/ a (global-linum-mode)' ~/.spacemacs  && \
    go get -u -v github.com/nsf/gocode && \
    go get -u -v github.com/rogpeppe/godef && \
    go get -u -v golang.org/x/tools/cmd/guru && \
    go get -u -v golang.org/x/tools/cmd/gorename && \
    go get -u -v golang.org/x/tools/cmd/goimports && \
    emacs -nw -batch -u johhy -kill
 
#  start emacs
ENTRYPOINT ["/bin/bash", "-c", "emacs -nw"]
