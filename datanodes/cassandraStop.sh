#!/bin/bash

. files/cluster-properties.sh

clush -g datanodes -l cassandra <<EOF
kill `cat $CASSANDRA_HOME_DIR/pid.file`
echo Ran kill `cat $CASSANDRA_HOME_DIR/pid.file` 
EOF

