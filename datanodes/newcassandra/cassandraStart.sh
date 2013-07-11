#!/bin/bash

. files/cluster-properties.sh

#since cassandra home is in the bashrc, we need to override it
clush -g datanodes -l cassandra <<EOF
export CASSANDRA_HOME=$CASSANDRA_HOME_DIR
export PATH=\$CASSANDRA_HOME/bin:\$PATH
cassandra -p $CASSANDRA_HOME_DIR/pid.file
EOF

