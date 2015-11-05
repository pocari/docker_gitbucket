FROM centos:7.1.1503

RUN yum -y update

#----------------------------------
# OS setting
#----------------------------------
RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN yum -y install ntp
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN ntpdate ntp.nict.jp

#----------------------------------
# nginx install
#----------------------------------
COPY ./resources/yum.nginx.repo /etc/yum.repos.d/
RUN yum -y install nginx

#----------------------------------
# GitBucket install
#----------------------------------
RUN yum -y install java-1.7.0-openjdk

ADD https://github.com/takezoe/gitbucket/releases/download/3.8/gitbucket.war /opt/gitbucket/gitbucket.war

#----------------------------------
# nginx setting
#----------------------------------
RUN mkdir -p /var/lib/nginx/cache
COPY ./resources/nginx/nginx.conf /etc/nginx/
COPY ./resources/nginx/default.conf /etc/nginx/conf.d/
EXPOSE 80

#----------------------------------
# gitbucket setting
#----------------------------------
COPY ./resources/gitbucket/gitbucket.conf /opt/gitbucket/
#for ssh access
EXPOSE 29418


RUN yum clean all

COPY ./resources/run.sh /root/

CMD ["sh", "/root/run.sh"]

