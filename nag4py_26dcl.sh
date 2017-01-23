#!/bin/bash
NAME=${1:-nag4py_26dcl}
echo Virtual Enviroment Name = ${NAME}
if ! hash virtualenv 2>/dev/null; then
    pip install virtualenv
fi
