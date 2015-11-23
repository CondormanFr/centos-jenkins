FROM centos:7

RUN yum -y install java-1.8.0-openjdk git

ENV JENKINS_VERSION 1.638
ENV JENKINS_SHA 8bed53c7309e46cb921d54cdbf41b254f1eaff88

RUN mkdir /opt/jenkins && \
    mkdir -p /opt/data/jenkins/war && \
    curl -fL http://mirrors.jenkins-ci.org/war/$JENKINS_VERSION/jenkins.war --output /opt/jenkins/jenkins.jar && \
    echo "$JENKINS_SHA /opt/jenkins/jenkins.jar" | sha1sum -c -

ENV JENKINS_HOME /opt/data/jenkins_home

RUN useradd -d "$JENKINS_HOME" -m -s /bin/bash jenkins 
VOLUME /opt/data/jenkins_home

EXPOSE 8080

USER jenkins

CMD java -Xms512m -Xmx1024m -jar /opt/jenkins/jenkins.jar
