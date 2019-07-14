#!/bin/sh

# start in right dir
cd /ircd-bin

# run!
/ircd-bin/inspircd start

touch a
tail -fn0 a

/ircd-bin/inspircd stop
