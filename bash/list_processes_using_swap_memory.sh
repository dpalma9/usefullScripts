#!/bin/bash

echo "First of all, use the following command to know what process you have to look on the generated list -->"
echo "for file in /proc/*/status ; do awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 2 -n -r | less"

overall=0
for status_file in /proc/[0-9]*/status; do
    swap_mem=$(grep VmSwap "$status_file" | awk '{ print $2 }')
    if [ "$swap_mem" ] && [ "$swap_mem" -gt 0 ]; then
        pid=$(grep Tgid "$status_file" | awk '{ print $2 }')
        name=$(grep Name "$status_file" | awk '{ print $2 }')
        printf "%s\t%s\t%s KB\n" "$pid" "$name" "$swap_mem" >> /tmp/pid_list.txt
    fi
    overall=$((overall+swap_mem))
done
printf "Total Swapped Memory: %14u KB\n" $overall
echo "Check the PID with swap usage on: /tmp/pid_list.txt"
