FROM centos:7

RUN yum -y install java-1.8.0-openjdk

ENV JENKINS_VERSION 1.636
ENV JENKINS_SHA 7c671378735106d87203005b9d03cde8df9981a9

RUN mkdir /opt/jenkins && \
    mkdir -p /opt/data/jenkins/war && \
    curl -fL http://mirrors.jenkins-ci.org/war/"$JENKINS_VERSION"/jenkins.war --output /opt/jenkins/jenkins.jar && \
    echo "$JENKINS_SHA /opt/jenkins/jenkins.jar" | sha1sum -c -

ENV JENKINS_HOME /opt/data/jenkins_home

EXPOSE 8080

CMD java -Xms512 -Xmx1024 -jar /opt/jenkins/jenkins.jar
