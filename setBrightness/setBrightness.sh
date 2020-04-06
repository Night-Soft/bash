#!/bin/bash
lastBrightness="$HOME/lastBrightness.txt"
brightness=""
writeToFile() {
sleep 20
setBrightness_acpi_video1=$(echo "123" | sudo -S sudo su -c 'echo '$brightness' > /sys/class/backlight/acpi_video1/brightness' )
notify-send --urgency=normal --expire-time=5000 "Brightness set = $brightness"
}
while IFS= read -r line
do
  echo "$line"
  if(($line >= 0 & $line <= 10))
  then
    brightness=$line
    writeToFile
  else
  brightness=5
  fi
done < "$lastBrightness"


