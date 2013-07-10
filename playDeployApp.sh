#!/bin/bash

export time=`date +%s`

mv /opt/controlcenter/staging/databus.zip /opt/binaries/databus$time.zip

clush -g webnodes -c /opt/binaries/databus$time.zip --dest=/opt/binaries/databus$time.zip
clush -g webnodes "cd /opt/binaries;unzip databus$time.zip"
clush -g webnodes mv /opt/binaries/webapp /opt/databus$time
clush -g webnodes chown -R play:play /opt/databus$time

echo /opt/databus$time > files/directory.tmp
