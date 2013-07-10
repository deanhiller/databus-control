#!/bin/bash

. files/cluster-properties.sh

clush -g datanodes -l cassandra <<EOF
cassandra -p $CASSANDRA_HOME_DIR/pid.file
EOF

