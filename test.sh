#!/bin/bash

. files/cluster-properties.sh

clush -g datanodes echo 'directory=$CASSANDRA_DIR'

clush -g datanodes <<\EOF
export READ=$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print $2}')
echo "listen_address: $READ" to directory $CASSANDRA_DUR
EOF

