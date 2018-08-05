#!/bin/bash
#set -x
echo $1
found=$(fgrep --text "At" $1 | fgrep "User" | fgrep "Time" | fgrep "(sec)")

#echo "$found"


echo "-----------------------------------------------------------------------"
echo "start:                   " $(echo "$found" | head -1 | cut -f 1 -d"," )
echo "currently (or finished): " $(echo "$found" | tail -1 | cut -f 1 -d"," )
echo "-----------------------------------------------------------------------"

#echo "Current time step is: "
last_progres_line=$(tail -1000 $1 | fgrep "TIMESTEP" | fgrep "OUT OF" | tail -1)

#select numbers from a phrase
groups=$(echo $last_progres_line | grep -Po '\d+')

i=0
for y in $groups
do
    counts[${i}]=$y
    let i=$(( ${i}+1 ))
done

total_steps=${counts[1]}
last_finished_step=${counts[0]}

nsteps=$( fgrep --text "TIMESTEP" $1 | fgrep "OUT OF" | wc -l)
echo "Performed ${nsteps} steps"

steps_todo=$(( ${total_steps} - ${last_finished_step} + 1 ))

echo "${steps_todo} steps left ..."

#egrep "At" $1 | egrep "User" | egrep "Time" | egrep "(sec)" | tail -1

