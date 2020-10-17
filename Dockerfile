FROM alpine:3.12

MAINTAINER scjtqs <jose@scjtqs.cn>


RUN  apk add --no-cache ca-certificates  git openjdk8 wget unzip which

ENV JAVA_HOME=/usr/java/default/ \
    ZK_HOSTS=localhost:2181 \
    KM_VERSION=1.3.1.8 \
    KM_REVISION=97329cc8bf462723232ee73dc6702c064b5908eb \
    KM_CONFIGFILE="conf/application.conf"

ADD start-kafka-manager.sh /kafka-manager-${KM_VERSION}/start-kafka-manager.sh


RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2 && \
    chmod +x /kafka-manager-${KM_VERSION}/start-kafka-manager.sh &&
#    yum autoremove -y java-1.8.0-openjdk-devel git wget unzip which && \

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./start-kafka-manager.sh"]
