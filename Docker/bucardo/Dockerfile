FROM ubuntu:xenial

LABEL maintainer="lucas@vieira.io"
LABEL version="1.0"

RUN apt-get -y update \
    && apt-get -y upgrade

RUN apt-get -y install vim
RUN apt-get -y install postgresql-9.5 bucardo jq

COPY etc/pg_hba.conf /etc/postgresql/9.5/main/
COPY etc/bucardorc /etc/bucardorc
COPY etc/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf

RUN chown postgres /etc/postgresql/9.5/main/pg_hba.conf
RUN chown postgres /etc/bucardorc
RUN chown postgres /etc/postgresql/9.5/main/postgresql.conf
RUN chown postgres /var/log/bucardo
RUN mkdir /var/run/bucardo && chown postgres /var/run/bucardo
RUN usermod -aG bucardo postgres

RUN service postgresql start \
    && su - postgres -c "bucardo install --batch"

COPY lib/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME "/media/bucardo"
CMD ["/bin/bash","-c","/entrypoint.sh"]

COPY /etc/bucardorc_after /etc/bucardorc

#RUN service postgresql start && su - postgres -c "psql -U postgres -d postgres -c \"Alter role bucardo login password 'selab';\""
ADD lib/startup.sh /startup.sh
RUN chmod +x /startup.sh
#RUN /startup.sh

