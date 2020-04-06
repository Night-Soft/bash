#!/bin/bash
start=$SECONDS
redColor="\e[1;101m"
blueColor="\e[1;44m"
closeColor="\e[0m"
notify-send --urgency=normal --expire-time=5000 "Checking Updates"
echo "123" | sudo -S apt-get update
echo -e "\e[1;37m\e[1;42m apt-get update FINISHED  \e[0m\e[0m"
closeAfter() {
for (( c=7; c>=0; c-- ))
do  
   echo -ne "Closing after: $blueColor $c $closeColor\033[0K\r"
   sleep 1
done
exit 0
}
listUpgrade() {
listt=$(sudo apt list --upgradable)
counter=0
while IFS= read -r line
do
   echo "$line"
   let "counter++"
   #echo "$counter"
done < <(printf '%s\n' "$listt")
if [ $counter == 1 ]
then
   echo -e "\nNothing to update, all ok!"
   notify-send --urgency=normal --expire-time=5000 "Nothing to update, all ok!"
   echo -e "\e[1;37m\e[1;42m apt list FINISHED  \e[0m\e[0m"
   exit 0
   #closeAfter
elif [ $counter > 1 ]
then
notify-send --urgency=normal --expire-time=5000 "There are Updates \n
open konsole"
konsole -e ./isUpdate.sh
exit 0
fi

echo -e "\e[1;37m\e[1;42m apt list FINISHED  \e[0m\e[0m"
}
listUpgrade




