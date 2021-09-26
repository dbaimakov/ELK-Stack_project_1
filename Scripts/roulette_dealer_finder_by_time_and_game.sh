
#!/bin/bash

date_arg=$1
time_arg=$2
# Format: Blackjack=BJ Roulette=RL Texas Hold Em=TH
game_arg=$3

# Combine any dealer schedule to STDOUT
for file in *_Dealer_schedule
do
  awk 'NR>2 { print FILENAME ( NF?" ":"" ) $0 }' $file | 
    # Change time format to save on typing
    # Example: "12AM"
    sed '$d;s/_Dealer_schedule//g;s/:00:00//g;s/ //2'
done |

  # Search for arguements
  grep -E $date_arg |
    grep -E $time_arg |

    # Search by game
    if [[ $game_arg == 'BJ' ]] ; then
      awk -F" " '{ print "Blackjack Dealer: " $3 " " $4 }'
    elif [[ $game_arg == 'RL' ]] ; then
      awk -F" " '{ print "Roulette Dealer: " $5 " " $6 }'
    elif [[ $game_arg == 'TH' ]] ; then
      awk -F" " '{ print "Texas Hold Em Dealer: "$7 " " $8 }'
    else 
      echo "Unaccepted input, accepted format:"
      echo "Blackjack=BJ"
      echo "Roulette=RL"
      echo "Texas Hold Em=TH"
    fi
