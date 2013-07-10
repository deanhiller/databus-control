#!/bin/bash

. files/cluster-properties.sh

clush -g datanodes -l cassandra <<EOF
echo dir=$CASSANDRA_HOME_DIR
#cat $CASSANDRA_HOME_DIR >> /home/cassandra/test.txt
#cassandra -p $CASSANDRA_HOME_DIR/pid.file
EOF

