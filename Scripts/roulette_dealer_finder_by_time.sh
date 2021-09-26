
#!/bin/bash

echo -e "Enter a number: \n 1 - All \n 2 - Blackjack \n 3 - Roulette \n 4 - Texas Hold EM"
read var4

echo "Please enter date: (Format: MMDD)"

read var1
echo "Please enter Time: (Format: HH:MM)"

read var2
echo "AM or PM?"

read var3

if  "$var4" = "1"
	then
		cat ${var1}_Dealer_schedule | grep ${var2} | grep ${var3} | awk -F'[\t]' '{print $0, $1, $2, $3, $4}'
	else
		cat ${var1}_Dealer_schedule | grep ${var2} | grep ${var3} | awk -F'[\t]' '{print $1}'
