#!/bin/bash

test -n "$1" || {
    echo "You have to specify an hostname/ip"
    exit 1
}

HERE=$(dirname $(readlink -e $BASH_SOURCE))

test -r $HERE/id_rsa || {
    echo "Cannot access the private key file"
    exit 1
}

ssh -p 2222 -D 8888 -N -i $HERE/id_rsa proxy@$1
