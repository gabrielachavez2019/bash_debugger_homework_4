#!/bin/bash

# Set a breakpoint at the given line number or list breakpoints
function _setbp
{
local i
if [ -z "$1" ]; then
_listbp
elif [ $(echo $1 | grep '^[0-9]*') ]; then
if [ -n "${_lines[$1]}" ]; then
_linebp=($(echo $( (for i in ${_linebp[*]} $1; do
echo $i; done) | sort -n) ))
_msg "Breakpoint set at line $1"
else
_msg "Breakpoints can only be set on non-blank lines"
fi
else
_msg "Please specify a numeric line number"
fi
}


function _clearbp
{
local i
if [ -z "$1" ]; then
unset _linebp[*]
_msg "All breakpoints have been cleared"
elif [ $(echo $1 | grep '^[0-9]*') ]; then
_linebp=($(echo $(for i in ${_linebp[*]}; do
if (( $1 != $i )); then echo $i; fi; done) ))
_msg "Breakpoint cleared at line $1"
else
_msg "Please specify a numeric line number"
fi
}

# See if this line number has a breakpoint
function _at_linenumbp
{
local i=0
if [ "$_linebp" ]; then
while (( $i < ${#_linebp[@]} )); do
if (( ${_linebp[$i]} == $_curline )); then
return 0
fi
let i=$i+1
done
fi
return 1
}


