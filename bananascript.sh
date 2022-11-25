#!/usr/bin/env bash

> banana.log #clear log file at start to avoid clutter
> stdin.txt #clear stdin input file 
echo "Input string, end with CTRL+D:" 
cp /dev/stdin  stdin.txt #copy string input to text file
nb=`tr '[:space:]' '[\n*]' < stdin.txt | grep -icw banana` # transform stdin to single line, search for magic word, ignore case
for (( c=0; c<$nb; c++ ))
do
	cat minion.txt >> banana.log #append to log file
done
echo $'\n'
echo "Check banana.log in the current directory. According to the number of bananas you entered, there should be ${nb} minion(s) in there."
echo $'\n'
echo "Server listening on TCP port 6987. Terminate socket with CTRL+C"
# local port
nc -l -p 6987

