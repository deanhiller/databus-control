#!/bin/bash

clush -g datanodes -l cassandra <<\EOF
cassandra -p /opt/cassandraB/pid.file
EOF

