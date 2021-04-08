FROM fauria/vsftpd

RUN yum -y update
RUN yum install -y vsftpd

ENV local_enable YES
ENV connect_from_port20 YES
ENV pam_service_name vsftpd
ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV LOCAL_UMASK 022
ENV FILE_OPEN_MODE 0666

EXPOSE 20 21
