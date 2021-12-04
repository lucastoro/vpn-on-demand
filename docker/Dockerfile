FROM alpine:latest
RUN apk update
RUN apk add openssh
WORKDIR /etc/ssh
RUN ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config
RUN adduser -D proxy
RUN passwd -u proxy
RUN mkdir -p /home/proxy/.ssh
COPY id_rsa.pub /home/proxy/.ssh/authorized_keys
RUN chown -R proxy:proxy /home/proxy
ENTRYPOINT ["/usr/sbin/sshd", "-D", "-ddd"]
