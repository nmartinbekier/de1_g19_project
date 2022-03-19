#classic_master.sh
#!/bin/bash
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

tar xvf config_files.tar
mv core-site.xml hadoop/etc/hadoop/
mv hdfs-site.xml hadoop/etc/hadoop/
mv mapred-site.xml hadoop/etc/hadoop/
mv masters hadoop/etc/hadoop/
mv workers hadoop/etc/hadoop/
mv yarn-site.xml hadoop/etc/hadoop/

# Remove in case there were previous incomplete configurations
rm -Rf /tmp/hadoop-ubuntu/*
rm -Rf /usr/local/hadoop/hdfs/data/*

# Install Spark
wget http://apache.mirrors.tds.net/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
tar -zxvf spark-3.2.1-bin-hadoop3.2.tgz
mv spark-3.2.1-bin-hadoop3.2 spark

echo "export HADOOP_HOME=/home/ubuntu/hadoop" >> ~/.bashrc
echo "export HADOOP_CONF_DIR=\$HADOOP_HOME/etc/hadoop" >> ~/.bashrc
echo "export SPARK_HOME=/home/ubuntu/spark" >> ~/.bashrc 
echo "export PATH=\$PATH:\$SPARK_HOME/bin" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$HADOOP_HOME/lib/native:\$LD_LIBRARY_PATH" >> ~/.bashrc
