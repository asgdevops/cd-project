# Build base image
FROM docker:dind 

LABEL maintainer="Antonio Salazar <antonio.salazar.devops@gmail.com>"

USER root

# Arguments
ARG username
ARG key

# Install sudo 
RUN apk update && apk add sudo 

# Set up user
RUN adduser $username -D -G wheel &&\
    echo "$username:$username" | chpasswd &&\
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel

# copy the SSH keys
COPY $key.pub /home/$username/.ssh/authorized_keys

RUN chown $(id -u $username):$(id -g $username) -R /home/$username/.ssh && \
    chmod 600 /home/$username/.ssh/authorized_keys

# Install ssh server
RUN apk add --no-cache openssh

# Configure SSHD
RUN mkdir /var/run/sshd
ADD ./sshd_config /etc/ssh/sshd_config
RUN ssh-keygen -A -v

USER $username
WORKDIR /home/$username

EXPOSE 22/tcp
EXPOSE 2376/tcp
ENTRYPOINT [ "dockerd-entrypoint.sh" ]
CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D"]

# sudo docker build . --build-arg key=jenkins_key --build-arg username=jenkins -f dind.Dockerfile -t dind/ssh:3.17