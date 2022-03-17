#start-spark.sh
#!/bin/bash
#
# Run related commands depending on SPARK_MODE 
#

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
mkdir -p /home/ubuntu/data/nameNode
mkdir -p /home/ubuntu/data/dataNode

if [ "$SPARK_MODE" == "master" ];
then

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
$HADOOP_HOME/bin/hdfs namenode -format

$SPARK_HOME/sbin/start-master.sh


elif [ "$SPARK_MODE" == "worker" ];
then

$SPARK_HOME/sbin/start-worker.sh spark://sparkmaster:7077

else
    echo "Undefined mode $SPARK_MODE, must specify: master, worker"
fi
