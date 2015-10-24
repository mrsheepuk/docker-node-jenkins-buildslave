# docker-node-jenkins-buildslave
A build slave for jenkins with node and the docker binaries installed. 

Designed to be bind-mounted to the docker port on the containing machine, to allow builds which use docker commands to use the host docker daemon.

Uses a UID of 1100 for the Jenkins user.
