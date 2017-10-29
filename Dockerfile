FROM amazonlinux:latest

RUN yum -y update && yum -y install openssh-server
RUN adduser testuser && mkdir -p /home/testuser/.ssh && chown testuser:testuser /home/testuser/.ssh && chmod 0700 /home/testuser/.ssh
ADD ./authorized_keys.pub /home/testuser/.ssh/authorized_keys
RUN chown testuser:testuser /home/testuser/.ssh/authorized_keys && chmod 0600 /home/testuser/.ssh/authorized_keys

CMD /etc/init.d/sshd start && tail -f /dev/null
