FROM node:4.1

RUN apt-get update && apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
RUN apt-get install -y openjdk-7-jdk

# Add user jenkins to the image
RUN groupadd -g 1100 jenkins
RUN useradd -u 1100 -m -g jenkins -s /bin/bash jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Add required NPM packages for building
RUN npm install -g bower gulp karma-cli

# Add docker, so we can use the docker command line (we'll bind-mount
# the /var/run/docker.sock to the parent machine so it can share that 
# instance).
RUN curl -sSL https://get.docker.com/ | sh 
# Add jenkins user to the docker group so it's permissioned.
RUN usermod -aG docker jenkins

# Add gcloud utils for jenkins user
USER jenkins
RUN curl https://sdk.cloud.google.com | bash
USER root

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
