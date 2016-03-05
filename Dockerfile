FROM java:8-jdk
MAINTAINER Benjamin Böhmke <benjamin@boehmke.net>

# get slave starter
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.52/remoting-2.52.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

# add jenkins user
RUN useradd -c "Jenkins user" -d /home/jenkins -m jenkins

# copy entry script
COPY jenkins.sh /usr/local/bin/jenkins
RUN chmod 755 /usr/local/bin/jenkins

# set environment
VOLUME /home/jenkins
WORKDIR /home/jenkins
USER jenkins

ENTRYPOINT ["/usr/local/bin/jenkins"]