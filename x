#!/bin/sh
SIP=$(tmux display-message -p "#S:#I:#P")
PTY=$(tmux server-info |
     egrep flags=\|bytes |
     awk '/windows/ { s = $2 }
          /references/ { i = $1 }
          /bytes/ { print s i $1 $2 } ' |
     grep "$SIP" |
     cut -d: -f4)
PTS=${PTY#/dev/}
PID=$(ps -eao pid,tty,command --forest | awk '$2 == "'$PTS'" {print $1; exit}')
DIR=$(readlink /proc/$PID/cwd)
echo $SIP
echo  " *************HELLO1*********************"
echo $PTY
echo  " *************HELLO1*********************"
echo $PTS
echo  " *************HELLO1*********************"
echo $PID
echo  " *************HELLO1*********************"
echo $DIR
echo  " *************HELLO1*********************"
