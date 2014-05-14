FROM ubuntu:14.04

MAINTAINER jan.matis@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# download and install updates, then add supervisor, wget and ssh server
RUN apt-get update 
RUN apt-get upgrade -y 
RUN apt-get install -y wget supervisor openssh-server rsyslog
RUN apt-get clean

RUN update-rc.d -f supervisor disable

# sshd modifications; switch off PAM for sshd as it does not work and i can not be bothered to investigate why 
RUN mkdir /var/run/sshd
RUN sed -e 's/UsePAM yes/UsePAM no/' -i /etc/ssh/sshd_config

# get locales
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

# basic supervisor config + make sure supervisor stays on foreground
RUN wget https://raw.githubusercontent.com/jmatis/ubuntu/master/supervisord.conf -O /etc/supervisor/supervisord.conf

# supervisor startscript for sshd
RUN wget https://raw.githubusercontent.com/jmatis/ubuntu/master/supervisord-ssh.conf -O /etc/supervisor/conf.d/ssh.conf

# supervisor startscript for rsyslogd
RUN wget https://raw.githubusercontent.com/jmatis/ubuntu/master/supervisord-rsyslogd.conf -O /etc/supervisor/conf.d/rsyslogd.conf

# user admin
RUN useradd -d /home/admin -m -G sudo -s /bin/bash admin
RUN echo "admin:newroot" | chpasswd

EXPOSE 22

CMD ["/usr/bin/supervisord"]
