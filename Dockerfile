FROM java:8-jdk
MAINTAINER Benjamin Böhmke <benjamin@boehmke.net>

# install docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-engine && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get slave starter
RUN curl --create-dirs -sSLo /opt/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.52/remoting-2.52.jar && \
    chmod 755 /opt/ && \
    chmod 644 /opt/slave.jar

# add jenkins user
RUN useradd -c "Jenkins user" -d /home/jenkins -m jenkins

# copy entry script
COPY jenkins.sh /opt/jenkins
RUN chmod 755 /opt/jenkins

# set environment
VOLUME /home/jenkins
WORKDIR /home/jenkins
USER jenkins

ENTRYPOINT ["/opt/jenkins"]