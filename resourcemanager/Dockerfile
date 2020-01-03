FROM bde2020/hadoop-base:3.2.1

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ENV SPARK_VERSION=2.4.4
ENV SPARK_HADOOP_COMPAT='2.7'

COPY ./sw/spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_COMPAT}.tgz spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_COMPAT}.tgz

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl bash python3 \
      && ln -s /lib64/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.2 \
      && chmod +x *.sh \
      # && wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_COMPAT}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_COMPAT} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${SPARK_HADOOP_COMPAT}.tgz \
      #&& cd /css \
      #&& jar uf /spark/jars/spark-core_2.11-${SPARK_VERSION}.jar org/apache/spark/ui/static/timeline-view.css \
      && cd /

COPY spark-defaults.conf /spark/conf/

ENV PATH $PATH:/spark/bin/

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]
