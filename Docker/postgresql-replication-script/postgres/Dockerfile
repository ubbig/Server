FROM postgres:13.0

RUN apt-get -y update

RUN apt-get -y install vim
RUN apt-get -y install ssh

#RUN service postgresql start && su - postgres -c "psql -U postgres -d postgres -c \"Alter role bucardo login password 'selab';\""
#ADD lib/startup.sh /startup.sh
#RUN chmod +x /startup.sh
#RUN /startup.sh
