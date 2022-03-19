#master-configuration.sh
#!/bin/bash

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sudo mkdir -p /usr/local/hadoop/hdfs/data
sudo chown ubuntu:ubuntu -R /usr/local/hadoop/hdfs/data
chmod 700 /usr/local/hadoop/hdfs/data

mkdir -p /home/ubuntu/data/nameNode
mkdir -p /home/ubuntu/data/dataNode

ssh-keygen -t rsa -P '' -f /home/ubuntu/.ssh/id_rsa
cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
chmod 0600 /home/ubuntu/.ssh/authorized_keys

$HADOOP_HOME/bin/hdfs namenode -format
$SPARK_HOME/sbin/start-master.sh
