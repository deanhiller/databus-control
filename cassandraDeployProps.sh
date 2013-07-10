#!/bin/bash

clush -g datanodes -c files/cassandra-topology.properties --dest='/opt/cassandraB/conf'
clush -g datanodes -c files/cassandra.yaml --dest='/opt/cassandraB/conf'

clush -g datanodes -l cassandra 'export READ=$(cat /opt/TOKEN.txt);echo "initial_token: $READ" >> /opt/cassandraB/conf/cassandra.yaml'


clush -g datanodes <<\EOF
export READ=$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print $2}')
echo "listen_address: $READ" >> /opt/cassandraB/conf/cassandra.yaml
EOF

