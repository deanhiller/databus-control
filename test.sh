#!/bin/bash

. files/cluster-properties.sh

echo dir=$CASSANDRA_DIR
echo dir2=$UNDEFINEDXXX

clush -g datanodes echo "directory=$CASSANDRA_DIR"

ssh root@sdi-prod-02 <<EOF
export READ=$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print $2}')
echo "listen_address: \$READ"
echo dir1=$CASSANDRA_DIR
echo dir2=\$CASSANDRA_DIR
echo dir3=\"$CASSANDRA_DIR\"
EOF


