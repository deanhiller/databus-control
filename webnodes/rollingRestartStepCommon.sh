#!/bin/bash

directory=`cat files/directory.tmp`

echo "About to deploy for dir=$directory"

clush -g webnodes hostname | sort > files/webnodes.tmp

targetIndex=$1

if [ -z "$1" ]
then
   echo "You need to supply the index of the server to upgrade"
   exit 56
fi

if [ -z "$2" ]
then
   echo "You need to supply the time to sleep like 30s for 30 seconds"
fi

echo "Target index=$targetIndex"

otherServers=()
y=0;
while read line
do 
   if [[ $y == $targetIndex ]] 
   then
      targetServer=`echo $line | cut -d: -f1`
      echo target server=$targetServer
   else
      otherServers+=(`echo $line | cut -d: -f1`)
   fi   
   let y++
done < "files/webnodes.tmp"

echo $targetServer > files/targetServer.tmp

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

echo "SLEEPING for time=$2 while requests finish on server=$targetServer"
sleep $2

echo "Shutting down the webserver now"

echo "ln -s $directory /opt/databus"

ssh $targetServer <<\EOF
   pkill -f 'java.*play'
   rm -rf /opt/databus
EOF

ssh $targetServer "ln -s $directory /opt/databus"

ssh -l play $targetServer <<\EOF
   cd /opt/databus
   ./startProduction.sh < /dev/null > /opt/databus/stdout.log 2>&1 &
EOF

echo "Waiting for server=$targetServer to boot up"
#give the server 30 seconds to come up
sleep 30s



