# Build base image
FROM centos/ssh:7 AS centos-agent
USER root

# Arguments
ARG username

# install packages: git, java, and maven
RUN yum install -qy git && \
    yum install -qy openjdk-11-jdk && \
    yum install -qy maven && \
    yum install -qy python3

# Set default working dir
USER $username
WORKDIR /home/$username

EXPOSE 22
CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D"]

# docker build . --build-arg username=centos -f centos-agent.Dockerfile -t centos/ssh:7
