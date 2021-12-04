#!/bin/bash

test -e id_rsa || {
    ssh-keygen && mv id_rsa.pub docker/
}
cd $(dirname $(readlink -e $BASH_SOURCE))/docker
docker build -t sshd .
