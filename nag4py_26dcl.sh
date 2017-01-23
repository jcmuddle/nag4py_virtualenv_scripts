#!/bin/bash
NAGLOC=${1:-1}
PYTHONV=${2:-3.5}
NAME=${3:-nag4py_26dcl}

if [ "$NAGLOC" == "1" ]; then
    echo "Please specify the location of the NAG C Library as the first arguement.";
    exit;
fi
if ! [ -d "$NAGLOC" ]; then
    echo $NAGLOC "Does not exist.";
    echo "Please enter the correct location of the NAG C Library";
    exit;
fi

NAGLIBLOC="${NAGLOC}lib/libnagc_nag.so"
if ! [ -e "$NAGLIBLOC" ]; then
    echo $NAGLIBLOC "Does not exist."
    exit;
fi

echo NAG Location = ${NAGLOC}
echo Virtual Enviroment Name = ${NAME}
if ! hash virtualenv 2>/dev/null; then
    echo "virtualenv must be installed to continue."
    while true; do
	read -p "Do you wish to install this program yes/no? " yn
	case $yn in
            [Yy]* ) pip install virtualenv; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
	esac
    done
fi

PYTHONLOC="/usr/bin/python"$PYTHONV
if ! [ -e $PYTHONLOC ]; then
    echo $PYTHONLOC" does not exist."
    echo "Using default Python."
    NORMALPYTHON="1"
fi

if [ "$NORMALPYTHON" == "1" ]; then
    echo "Python Version = Default"
    FULLNAME=$NAME
    virtualenv $FULLNAME
else
    echo "Python Version = Python"$PYTHONV
    FULLNAME=$NAME"_"$PYTHONV
    virtualenv -p $PYTHONLOC $FULLNAME
fi

ACT=./$FULLNAME/bin/activate

echo '# This file must be used with "source bin/activate" *from bash*' > $ACT
echo '# you cannot run it directly' >> $ACT
echo '' >> $ACT
echo 'deactivate () {' >> $ACT
echo '    unset -f pydoc >/dev/null 2>&1' >> $ACT
echo '' >> $ACT
echo '    # reset old environment variables' >> $ACT
echo '    # ! [ -z ${VAR+_} ] returns true if VAR is declared at all' >> $ACT
echo '    if ! [ -z "${_OLD_VIRTUAL_PATH+_}" ] ; then' >> $ACT
echo '        PATH="$_OLD_VIRTUAL_PATH"' >> $ACT
echo '        export PATH' >> $ACT
echo '        unset _OLD_VIRTUAL_PATH' >> $ACT
echo '    fi' >> $ACT
echo '    if ! [ -z "${_OLD_VIRTUAL_PYTHONHOME+_}" ] ; then' >> $ACT
echo '        PYTHONHOME="$_OLD_VIRTUAL_PYTHONHOME"' >> $ACT
echo '        export PYTHONHOME' >> $ACT
echo '        unset _OLD_VIRTUAL_PYTHONHOME' >> $ACT
echo '    fi' >> $ACT
echo '    if ! [ -z "${_OLD_LD_LIBRARY_PATH+_}" ] ; then' >> $ACT
echo '        LD_LIBRARY_PATH="$_OLD_LD_LIBRARY_PATH"' >> $ACT
echo '        export LD_LIBRARY_PATH' >> $ACT
echo '        unset _OLD_LD_LIBRARY_PATH' >> $ACT
echo '    fi' >> $ACT
echo '    ' >> $ACT
echo '    # This should detect bash and zsh, which have a hash command that must' >> $ACT
echo '    # be called to get it to forget past commands.  Without forgetting' >> $ACT
echo '    # past commands the $PATH changes we made may not be respected' >> $ACT
echo '    if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then' >> $ACT
echo '        hash -r 2>/dev/null' >> $ACT
echo '    fi' >> $ACT
echo '' >> $ACT
echo '    if ! [ -z "${_OLD_VIRTUAL_PS1+_}" ] ; then' >> $ACT
echo '        PS1="$_OLD_VIRTUAL_PS1"' >> $ACT
echo '        export PS1' >> $ACT
echo '        unset _OLD_VIRTUAL_PS1' >> $ACT
echo '    fi' >> $ACT
echo '' >> $ACT
echo '    unset VIRTUAL_ENV' >> $ACT
echo '    if [ ! "${1-}" = "nondestructive" ] ; then' >> $ACT
echo '    # Self destruct!' >> $ACT
echo '        unset -f deactivate' >> $ACT
echo '    fi' >> $ACT
echo '}' >> $ACT
echo '' >> $ACT
echo '# unset irrelevant variables' >> $ACT
echo 'deactivate nondestructive' >> $ACT
echo '' >> $ACT
echo 'VIRTUAL_ENV="/home/john/mark26/py27dcl"' >> $ACT
echo 'export VIRTUAL_ENV' >> $ACT
echo '' >> $ACT
echo '_OLD_VIRTUAL_PATH="$PATH"' >> $ACT
echo 'PATH="$VIRTUAL_ENV/bin:$PATH"' >> $ACT
echo 'export PATH' >> $ACT
echo '' >> $ACT
echo '_OLD_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"' >> $ACT
echo 'LD_LIBRARY_PATH="'${NAGLOC}'lib:$LD_LIBRARY_PATH"' >> $ACT
echo 'LD_LIBRARY_PATH="'${NAGLOC}'rtl/intel64:$LD_LIBRARY_PATH"' >> $ACT
echo 'export LD_LIBRARY_PATH' >> $ACT
echo '' >> $ACT
echo '# unset PYTHONHOME if set' >> $ACT
echo 'if ! [ -z "${PYTHONHOME+_}" ] ; then' >> $ACT
echo '    _OLD_VIRTUAL_PYTHONHOME="$PYTHONHOME"' >> $ACT
echo '    unset PYTHONHOME' >> $ACT
echo 'fi' >> $ACT
echo '' >> $ACT
echo 'if [ -z "${VIRTUAL_ENV_DISABLE_PROMPT-}" ] ; then' >> $ACT
echo '    _OLD_VIRTUAL_PS1="$PS1"' >> $ACT
echo '    if [ "x" != x ] ; then' >> $ACT
echo '        PS1="$PS1"' >> $ACT
echo '    else' >> $ACT
echo '        PS1="(`basename \"$VIRTUAL_ENV\"`) $PS1"' >> $ACT
echo '    fi' >> $ACT
echo '    export PS1' >> $ACT
echo 'fi' >> $ACT
echo '' >> $ACT
echo "# Make sure to unalias pydoc if it's already there" >> $ACT
echo 'alias pydoc 2>/dev/null >/dev/null && unalias pydoc' >> $ACT
echo '' >> $ACT
echo 'pydoc () {' >> $ACT
echo '    python -m pydoc "$@"' >> $ACT
echo '}' >> $ACT
echo '' >> $ACT
echo '# This should detect bash and zsh, which have a hash command that must' >> $ACT
echo '# be called to get it to forget past commands.  Without forgetting' >> $ACT
echo '# past commands the $PATH changes we made may not be respected' >> $ACT
echo 'if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then' >> $ACT
echo '    hash -r 2>/dev/null' >> $ACT
echo 'fi' >> $ACT

echo "Activate with:"
echo "$ source" ${FULLNAME}"/bin/activate"
echo "Deactivate with:"
echo "$ deactivate"
