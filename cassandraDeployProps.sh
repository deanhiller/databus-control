#!/bin/bash

. files/cluster-properties.sh

clush -g datanodes -c files/cassandra-topology.properties --dest="$CASSANDRA_HOME_DIR/conf"
clush -g datanodes -c files/cassandra.yaml --dest="$CASSANDRA_HOME_DIR/conf"

clush -g datanodes <<EOF
export TOKEN=$(cat /opt/TOKEN.txt)
export READ=$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print $2}')
echo "initial_token: \$READ" >> /opt/cassandraB/conf/cassandra.yaml
echo "listen_address: \$READ" >> $CLUSTER_DIR/conf/cassandra.yaml
EOF

