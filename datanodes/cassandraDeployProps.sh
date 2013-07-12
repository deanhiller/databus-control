#!/bin/bash

. files/cluster-properties.sh

clush -g datanodes -c files/cassandra-topology.properties --dest="$CASSANDRA_HOME_DIR/conf"
clush -g datanodes -c files/cassandra.yaml --dest="$CASSANDRA_HOME_DIR/conf"

clush -g datanodes <<EOF
export TOKEN=\$(cat /opt/TOKEN.txt)
export IP=\$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print \$2}')
echo "initial_token: \$TOKEN" >> $CASSANDRA_HOME_DIR/conf/cassandra.yaml
echo "listen_address: \$IP" >> $CASSANDRA_HOME_DIR/conf/cassandra.yaml
EOF

