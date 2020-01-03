DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
IMAGE_TAG = 3.2.1

build:
	docker build -t bde2020/hadoop-base:${IMAGE_TAG} ./base
	docker build -t bde2020/hadoop-namenode:${IMAGE_TAG} ./namenode
	docker build -t bde2020/hadoop-datanode:${IMAGE_TAG} ./datanode
	docker build -t bde2020/hadoop-resourcemanager:${IMAGE_TAG} ./resourcemanager
	docker build -t bde2020/hadoop-nodemanager:${IMAGE_TAG} ./nodemanager
	docker build -t bde2020/hadoop-historyserver:${IMAGE_TAG} ./historyserver
	docker build -t bde2020/hadoop-submit:${IMAGE_TAG} ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -copyFromLocal /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -rm -r /input
