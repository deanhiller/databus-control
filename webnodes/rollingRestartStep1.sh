#!/bin/bash

#The first step is deploying the application to ALL servers AND
# taking first server out of load balancer, waiting 30 seconds and then shutting down the first server AND
# then setting up symlinks and starting the new server which can be tested directly
#
# The second step will hook up the loadbalancer for further testing.  The 3rd step does all other nodes in a rolling restart fashion

echo "Displaying hard disk space and sleeping so kill this process if too much disk space used"

clush -g allwebnodes df -h /
df -h 

echo "Sleeping, kill process if any node is using too much disk"
sleep 20s

echo "Deplying app to all servers to start with"

./playDeployApp.sh

echo "Calling upgrade on the very first node"
./rollingRestartStepCommon.sh 0 1m

