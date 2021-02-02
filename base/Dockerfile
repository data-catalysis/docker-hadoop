FROM debian:9

MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>
MAINTAINER Giannis Mouchakis <gmouchakis@iit.demokritos.gr>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-8-jdk \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
      python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*
      
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION 3.2.2
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

# Install Python
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential checkinstall \
      libreadline-gplv2-dev libncursesw5-dev libssl-dev \
      libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

ENV PYTHON_VERSION 3.7.9
RUN set -x \
    && curl -fSL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz" -o /tmp/Python-$PYTHON_VERSION.tgz \
    && tar -xvf /tmp/Python-$PYTHON_VERSION.tgz -C /opt/ \
    && cd /opt/Python-$PYTHON_VERSION \
    && ./configure --enable-optimizations \
    && make altinstall \
    && rm /tmp/Python-$PYTHON_VERSION.tgz

# RUN set -x \
#     && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
#     && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
#     && gpg --verify /tmp/hadoop.tar.gz.asc \
#     && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
#     && rm /tmp/hadoop.tar.gz*

COPY ./sw/hadoop-${HADOOP_VERSION}.tar.gz hadoop-${HADOOP_VERSION}.tar.gz

RUN set -x \
    # && wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ \
    && rm hadoop-${HADOOP_VERSION}.tar.gz \
    && cd /

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
