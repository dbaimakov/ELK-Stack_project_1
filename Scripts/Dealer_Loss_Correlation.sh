#! /bin/bash

# Set time/date of loss as an array
set -a time_array
time_array=$(awk '{print $1,$2}' Roulette_Losses | sed 's/ /:/1')

# Combine any dealer schedule to temp file
for file in *_Dealer_schedule
do
  awk 'NR>2 { print FILENAME (NF?":":"") $0}' $file | sed \
  '$d;s/_Dealer_schedule//g;s/ //1' >> dealer_sched
done 

# search for matches from Roulette_Losses
for time in ${time_array[@]}
do
  grep $time dealer_sched |
    awk -F"\t" '{ print $1,$3 }' |
    sed 's/:/ /1'
done | sort

#! /usr/bin/env bah

