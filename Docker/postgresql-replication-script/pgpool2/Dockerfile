FROM postgres:13.0

RUN apt-get -y update
RUN apt-get -y install pgpool2
RUN apt-get -y install vim
RUN apt-get -y install openssh-server
RUN service ssh start
CMD ["/usr/sbin/sshd","-D"]
CMD ["/usr/sbin/pgpool", "-n"]
