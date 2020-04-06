#!/bin/bash
#id=$(wmctrl -l | grep -oP "(?<=)(0x\w+)(?=.*chrome)") 
#id=$(wmctrl -l "chrome") 
#xdotool key --window $id "ctrl+l"
#xdotool key --window $id "ctrl+c"
sleep 0.5
startWith="https://www.youtube.com/watch"
url=$(xclip -o -selection clipboard)
HOST=user1
smpAgr1="mingui"
smpAgr2="ontop"
smpArg3=(config-path)
smpArg4=(/home/yurii/smp)
smp='smplayer -defaultgui -ontop -config-path /home/yurii/smp $url' #$smpArg1 $smpArg2 #$smpArg3 $smpArg4

mpv="mpv"
vlc="vlc"
player=($smp $mpv $vlc)
declare -i x=0
echo $x
#run=${player[1]} $url
#Players=
if  [[ $url == $startWith* ]];
then
    echo true
    notify-send --urgency=normal --expire-time=5000 "start ${player[$x]} Player"
    #echo ${player[1]}
    ${player[$x]} $url
    wmctrl -r "SMPlayer" -b add,above
    #$run 
    list=$(wmctrl -l)
    echo $list
    echo "url is $url"
    #smplayer -defaultgui -ontop -config-path /home/yurii/smp $url
    #Valid format: [W[%][xH[%]]][{+-}X[%]{+-}Y[%]] | [X[%]:Y[%]]
    #mpv  -ontop -geometry=350x250+100%+100% $url
   # vlc $url

else
    echo false
    notify-send --urgency=normal --expire-time=7000 "Incorrect url, failed to start ${player[$x]} Player"

fi

