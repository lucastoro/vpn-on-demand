#!/bin/bash

HERE=$(dirname $(readlink -e $BASH_SOURCE))

ssh -p 2222 -D 8888 -N -i $HERE/id_rsa proxy@localhost
