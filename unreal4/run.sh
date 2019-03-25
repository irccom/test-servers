#!/bin/sh

# start in right dir
cd /ircd-bin

# run!
su ircd -c '/ircd-bin/unrealircd start'

touch a
tail -fn0 a

su ircd -c '/ircd-bin/unrealircd stop'
