#!/bin/bash


clush -g datanodes -l cassandra <<\EOF
kill `cat /opt/cassandraB/pid.file`
echo Ran kill `cat /opt/cassandraB/pid.file` 
EOF

