#!/bin/bash
start=$SECONDS
redColor="\e[1;101m"
blueColor="\e[1;44m"
closeColor="\e[0m"

closeAfter() {
for (( c=7; c>=0; c-- ))
do  
   echo -ne "Closing after: $blueColor $c $closeColor\033[0K\r"
   sleep 1
done
exit 0
}
listUpgrade() {
listt=$(echo "123" | sudo -S apt list --upgradable)
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
   echo -e "\e[1;37m\e[1;42m apt list FINISHED  \e[0m\e[0m"

   closeAfter
fi
echo -e "\e[1;37m\e[1;42m apt list FINISHED  \e[0m\e[0m"
}
listUpgrade

###### UPDATE
update() {
sudo apt -y full-upgrade
duration=$((SECONDS - start))
echo -e "\e[1;37m\e[1;42m full-upgrade FINISHED at $duration seconds \e[0m\e[0m"
notify-send --urgency=normal --expire-time=5000 "Update FINISHED"
closeAfter
}
###### UPDATE FINISHED
readInput() {
yesOrNow="n"
echo "Update now? [y/n]"
read -n 5 inp
echo "$inp" | tr '[:upper:]' '[:lower:]'
if [ $inp == "y" ]
then
   echo "Ok"
   update
elif [ $inp == "n" ]   
then 
   echo "Cancel"
   closeAfter
else
   echo -e "$redColor Wrong input$closeColor, try again"
   readInput
fi
}
readInput



