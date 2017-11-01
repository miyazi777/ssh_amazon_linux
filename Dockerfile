FROM amazonlinux:latest

ARG USER

RUN yum -y update && yum -y install openssh-server && yum -y install sudo
RUN adduser $USER && mkdir -p /home/$USER/.ssh && chown $USER:$USER /home/$USER/.ssh && chmod 0700 /home/$USER/.ssh
ADD ./authorized_keys.pub /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys && chmod 0600 /home/$USER/.ssh/authorized_keys
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

CMD /etc/init.d/sshd start && tail -f /dev/null
