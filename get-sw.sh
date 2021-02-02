#!/bin/sh

HADOOP_VERSION='3.2.2'
SPARK_VERSION='2.4.7'
SPARK_HADOOP_COMPAT='2.7'

APACHE_MIRROR="https://archive.apache.org/dist/"

HADOOP_TARFILE="hadoop-${HADOOP_VERSION}.tar.gz"
HADOOP_APACHE_PATH="hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TARFILE}"
SPARK_TARFILE="spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_COMPAT}.tgz"
SPARK_APACHE_PATH="spark/spark-${SPARK_VERSION}/${SPARK_TARFILE}"

mkdir -p base/sw
mkdir -p resourcemanager/sw
wget -nc ${APACHE_MIRROR}${HADOOP_APACHE_PATH} -O base/sw/${HADOOP_TARFILE}
wget -nc ${APACHE_MIRROR}${SPARK_APACHE_PATH} -O resourcemanager/sw/${SPARK_TARFILE}

