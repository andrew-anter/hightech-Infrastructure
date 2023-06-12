FROM ubuntu:18.04

USER root

RUN mkdir -p /var/jenkins_home /home/jenkins
# this RUN instruction creates two directories inside the Docker image: /var/jenkins_home and /home/jenkins. 
RUN adduser jenkins; echo "jenkins:123456789" | chpasswd

RUN chown -R jenkins:jenkins /var/jenkins_home /home/jenkins

WORKDIR /home/jenkins

# install docker, ssh ..........
#dist-upgrade upgrades the entire distribution. 
#It considers dependencies and conflicts between packages and resolves them automatically.
RUN apt-get update && apt-get dist-upgrade -y && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y \
    git \
    apt-transport-https \
    curl \
    init \
    openssh-server openssh-client \
    docker.io \
    vim \
    && rm -rf /var/lib/apt/lists/* \
    && chmod 777 /var/run/docker.sock

#install kubectl
RUN apt update \
    && apt-get install gnupg gnupg1 gnupg2 -y
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN touch /etc/apt/sources.list.d/kubernetes.list 
RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/*
# same jdk of jenkins master

EXPOSE 22
# tail -f the "f" stands for follow it monitors the file in real-time
ENTRYPOINT service ssh restart && tail -f /dev/null