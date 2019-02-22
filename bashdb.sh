#!/bin/bash 

#set -o noexec    #Dont run commands; check for syntax errors only

# bashdb - a bash debugger
# Driver Script: concatenates the preamble and the target script
# and then executes the new script.

echo 'bash Debugger version 1.0'

_dbname=${0##*/}

if (( $# < 1 )) ; then
    echo "$_dbname: Usage: $_dbname filename" >&2
    exit 1
fi

_guineapig=$1

if [ ! -r $1 ]; then
    echo "$_dbname: Cannot read file '$_guineapig'." >&2
    exit 1
fi

shift

_tmpdir=/tmp
_libdir=.
_debugfile=$_tmpdir/bashdb.$$ # temporary file for script that is being debugged
cat $_libdir/bashdb.pre $_guineapig > $_debugfile
exec bash $_debugfile $_guineapig $_tmpdir $_libdir "$@"  #runs the newly created script
