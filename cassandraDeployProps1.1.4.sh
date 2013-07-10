#!/bin/bash

clush -g datanodes -c cassandra-topology.properties --dest='/opt/cassandra-1.1.4/conf'
clush -g datanodes -c cassandra.yaml.1.1.4 --dest='/opt/cassandra-1.1.4/conf/cassandra.yaml'

clush -g datanodes -l cassandra 'export READ=$(cat /opt/TOKEN.txt);echo "initial_token: $READ" >> /opt/cassandra-1.1.4/conf/cassandra.yaml'


clush -g datanodes <<\EOF
export READ=$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print $2}')
echo "listen_address: $READ" >> /opt/cassandra-1.1.4/conf/cassandra.yaml
EOF

