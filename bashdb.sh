#!/bin/bash

#set -o noexec
#set -o verbose
set -o xtrace

#trap 'echo exiting from the script' EXIT
#echo 'start the script'

trap 'echo Thank you for playing!' EXIT
magicnum=$(($RANDOM%10+1))

echo 'guess a number between 1 and 10: '
while read -p 'Guess: ' guess ; do
    sleep 4
    if [ "$guess" = $magicnum ]; then
       echo 'Right!'
       exit
    fi
    echo 'Wrong!'
done

