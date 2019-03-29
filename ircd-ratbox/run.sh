#!/bin/sh

# start in right dir
cd /ircd-bin

# run!
su ircd -c '/ircd-bin/bin/ircd -foreground'
