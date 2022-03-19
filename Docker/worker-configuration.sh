#worker-configuration.sh
#!/bin/bash

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sudo mkdir -p /usr/local/hadoop/hdfs/data
sudo chown ubuntu:ubuntu -R /usr/local/hadoop/hdfs/data
chmod 700 /usr/local/hadoop/hdfs/data

mkdir -p /home/ubuntu/data/nameNode
mkdir -p /home/ubuntu/data/dataNode

$SPARK_HOME/sbin/start-worker.sh spark://sparkmaster:7077
