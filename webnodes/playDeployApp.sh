#!/bin/bash

export time=`date +%s`

mv /opt/controlBcenter/webnodes/staging/databus.zip /opt/binaries/databus$time.zip

clush -g webnodes -c /opt/binaries/databus$time.zip --dest=/opt/binaries/databus$time.zip
clush -g webnodes "cd /opt/binaries;unzip databus$time.zip"
clush -g webnodes mv /opt/binaries/webapp /opt/databus$time
clush -g webnodes chown -R play:play /opt/databus$time
clush -g webnodes rm /opt/binaries/databus$time.zip

clush -g webnodes cp /opt/databus$time/conf/application.conf.prod /opt/databus$time/conf/application.conf

echo /opt/databus$time > files/directory.tmp
