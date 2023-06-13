FROM ubuntu:18.04
USER root
RUN mkdir -p /var/jenkins_home /home/jenkins
# this RUN instruction creates two directories inside the Docker image: /var/jenkins_home and /home/jenkins. 
RUN adduser jenkins; echo "jenkins:123456789" | chpasswd \ 
    && chown -R jenkins:jenkins /var/jenkins_home /home/jenkins

WORKDIR /home/jenkins

# install docker, ssh ..........
#dist-upgrade upgrades the entire distribution. 
#It considers dependencies and conflicts between packages and resolves them automatically.
RUN apt-get update && apt-get dist-upgrade -y && rm -rf /var/lib/apt/lists/* \
 && apt-get update && apt-get install -y \
    git \
    apt-transport-https \
    curl \
    init \
    openssh-server openssh-client \
    docker.io \
    vim \
 && rm -rf /var/lib/apt/lists/*

#install kubectl
RUN apt update \
 && apt-get install gnupg gnupg1 gnupg2 -y \
 && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && touch /etc/apt/sources.list.d/kubernetes.list \
 && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
 && apt-get update && apt-get install -y kubectl \
 && apt-get install apt-transport-https ca-certificates gnupg curl sudo -y && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && apt-get update && sudo apt-get install google-cloud-cli -y

#install helm3
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 -o get_helm.sh  \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

#install gcloud cli
RUN apt-get install apt-transport-https ca-certificates gnupg curl sudo -y \
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
 && apt-get update \
 && sudo apt-get install google-cloud-cli -y

# install gke-gcloud-auth-plugin
RUN apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y

# install envsubst
RUN apt-get install gettext-base -y 

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/*
# same jdk of jenkins master
    
EXPOSE 22
# tail -f the "f" stands for follow it monitors the file in real-time and chmod command to allow jenkins user to access docker socket
ENTRYPOINT ["/bin/bash", "-c", "service ssh start && tail -f /dev/null && chmod 777 /var/run/docker.sock"]
