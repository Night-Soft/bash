#!/bin/bash
currentBrightness="/sys/class/backlight/acpi_video1/actual_brightness"
lastBrightness="$HOME/lastBrightness.txt"
brightness=""
writeToFile() {
echo "$brightness" > $lastBrightness
#notify-send --urgency=normal --expire-time=5000 "Current Brightness is = $brightness"
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
done < "$currentBrightness"
