DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
IMAGE_TAG = 3.2.2

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
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -copyFromLocal /opt/hadoop-${IMAGE_TAG}/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${IMAGE_TAG} hdfs dfs -rm -r /input

start_local_cluster_1:
	docker-compose -f docker-compose-local.yml up -d namenode
	docker-compose -f docker-compose-local.yml up -d datanode
	docker-compose -f docker-compose-local.yml up -d nodemanager
	docker-compose -f docker-compose-local.yml up -d historyserver

start_local_cluster_2:
	docker-compose -f docker-compose-local.yml up -d resourcemanager

stop_local_cluster:
	docker-compose -f docker-compose-local.yml down

show_local_cluster_logs:
	docker-compose -f docker-compose-local.yml logs -f
