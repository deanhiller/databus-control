#!/bin/bash

#run clush -g datanodes cp /opt/TOKEN.txt /opt/TOKEN2.txt
#generate tokens with python -c 'print [str(((2**64 / 4) * i) - 2**63) for i in range(4)]' and put in TOKEN2.txt files all around
#modify the cassandra-topologies to be ALL IP addresses only!!!!
#need to worry about the .bashrc script and when we finally modify that one as well

. files/cluster-properties.sh

clush -g datanodes mkdir /var/log/cassandrB
clush -g datanodes mkdir /opt/cassandra-1.2.2b
clush -g datanodes chown cassandra:cassandra /var/log/cassandrB
clush -g datanodes chown cassandra:cassandra /opt/cassandra-1.2.2b
clush -g datanodes ln -s /opt/cassandra-1.2.2b /opt/cassandraB
clush -g datanodes cp -r /opt/cassandra/* /opt/cassandraB

clush -g datanodes -c files/cassandra-topology.properties --dest="$CASSANDRA_HOME_DIR/conf"
clush -g datanodes -c files/log4j-server.properties --dest="$CASSANDRA_HOME_DIR/conf"
clush -g datanodes -c files/cassandra-env.sh --dest="$CASSANDRA_HOME_DIR/conf"
clush -g datanodes -c files/cassandra.yaml --dest="$CASSANDRA_HOME_DIR/conf"

clush -g datanodes <<EOF
export TOKEN=\$(cat /opt/TOKEN2.txt)
export IP=\$(grep IPADDR /etc/sysconfig/network-scripts/ifcfg-eth0 |awk -F= '{print \$2}')
echo "initial_token: \$TOKEN" >> $CASSANDRA_HOME_DIR/conf/cassandra.yaml
echo "listen_address: \$IP" >> $CASSANDRA_HOME_DIR/conf/cassandra.yaml
EOF

