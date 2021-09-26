#! /bin/bash

grep '11' 0315* |awk '{print $1, $2, $5, $6}' |

grep -i pm >> Dealers_working_during_losses.txt

awk '/^11/{$0=$1 OFS $2 OFS $5 OFS $6; if (tolower($2) == "pm") print}' 0315* >> Dealers_working_during_losses.txt

#! /usr/bin/env bah

