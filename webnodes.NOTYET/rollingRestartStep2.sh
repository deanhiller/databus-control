#!/bin/bash

echo "Ressetting load balancer to contain all servers again"

while read line
do
    otherServers+=(`echo $line | cut -d: -f1`)
done < "files/webnodes.tmp"

export thePath=/etc/nginx/rollingRestart

clush -g lbnodes "cat $thePath/beginOfFile.conf > $thePath/current.conf"

for server in "${otherServers[@]}"
do
   echo "Adding server to load balancer=$server"

   clush -g lbnodes "echo '  server $server:8080;' >> $thePath/current.conf"
done

clush -g lbnodes "cat $thePath/endOfFile.conf >> $thePath/current.conf"

echo "RELOADING the load balancer"

clush -g lbnodes "cp $thePath/current.conf /etc/nginx/conf.d/default.conf"

clush -g lbnodes "service nginx reload"

