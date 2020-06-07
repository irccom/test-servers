#!/bin/sh

# start in right dir
cd /ircd-bin

# run!
/ircd-bin/inspircd start #--debug

touch junk/a
tail -fn0 junk/a

/ircd-bin/inspircd stop
