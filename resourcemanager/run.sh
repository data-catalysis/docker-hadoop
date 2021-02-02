#!/bin/bash

. "/spark/sbin/spark-config.sh"

. "/spark/bin/load-spark-env.sh"

$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR resourcemanager
