#project_worker_init.sh
#!/bin/bash
#
# Script to be run in worker VMs (NOT IN MASTER)
#
# IMPORTANT: After running this script, run `source ~/.bashrc` so the environment
# variables get actually set
cd ~/

sudo apt update
sudo apt-get install -y openjdk-8-jdk

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc

wget http://apache.mirrors.tds.net/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
tar -xvf hadoop-3.3.0.tar.gz
rm hadoop-3.3.0.tar.gz
mv hadoop-3.3.0 hadoop

echo "export HADOOP_HOME=/home/ubuntu/hadoop" >> ~/.bashrc
echo "export PATH=\$PATH:\$HADOOP_HOME/bin" >> ~/.bashrc
echo "export PATH=\$PATH:\$HADOOP_HOME/sbin" >> ~/.bashrc
echo "export HADOOP_MAPRED_HOME=\${HADOOP_HOME}" >> ~/.bashrc
echo "export HADOOP_COMMON_HOME=\${HADOOP_HOME}" >> ~/.bashrc
echo "export HADOOP_HDFS_HOME=\${HADOOP_HOME}" >> ~/.bashrc
echo "export YARN_HOME=\${HADOOP_HOME}" >> ~/.bashrc

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> hadoop/etc/hadoop/hadoop-env.sh

sudo mkdir -p /usr/local/hadoop/hdfs/data
sudo chown ubuntu:ubuntu -R /usr/local/hadoop/hdfs/data
chmod 700 /usr/local/hadoop/hdfs/data

mv ~/config_files/hadoop/core-site.xml ~/hadoop/etc/hadoop/
mv ~/config_files/hadoop/hdfs-site.xml ~/hadoop/etc/hadoop/
mv ~/config_files/hadoop/mapred-site.xml ~/hadoop/etc/hadoop/
mv ~/config_files/hadoop/masters ~/hadoop/etc/hadoop/
mv ~/config_files/hadoop/workers ~/hadoop/etc/hadoop/
mv ~/config_files/hadoop/yarn-site.xml ~/hadoop/etc/hadoop/

# Remove Hadoop data files in case there were previous incomplete configurations
rm -Rf /tmp/hadoop-ubuntu/*
rm -Rf /usr/local/hadoop/hdfs/data/*

# Install Spark
# However, if we're using YARN this is not needed, as the Master makes Spark
# libraries and other resources available to nodes via HDFS
wget http://apache.mirrors.tds.net/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
tar -zxvf spark-3.2.1-bin-hadoop3.2.tgz
mv spark-3.2.1-bin-hadoop3.2 spark

echo "export HADOOP_HOME=/home/ubuntu/hadoop" >> ~/.bashrc
echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> ~/.bashrc
echo "export SPARK_HOME=/home/ubuntu/spark" >> ~/.bashrc 
echo "export PATH=\$PATH:\$SPARK_HOME/bin" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$HADOOP_HOME/lib/native:\$LD_LIBRARY_PATH" >> ~/.bashrc

