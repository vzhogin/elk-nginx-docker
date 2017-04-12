FROM nginx
MAINTAINER Omar Ewedah "omar.ewedah@gmail.com"


### install Filebeat

RUN apt-get update \
 && apt-get -y install curl \
 && apt-get -y install wget \
 && apt-get -y install apt-transport-https \
 && echo "deb https://packages.elastic.co/beats/apt stable main" |  tee -a /etc/apt/sources.list.d/beats.list \
 && wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch |  apt-key add - \
 && apt-get update \
 && apt-get install filebeat

RUN truncate -s 1k /usr/share/nginx/html/test.html \
 && truncate -s 1k /usr/share/nginx/html/test.jpg \
 && truncate -s 1k /usr/share/nginx/html/test.css \
 && truncate -s 1k /usr/share/nginx/html/test.js
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf


# remove log symlinks
RUN rm /var/log/nginx/access.log /var/log/nginx/error.log


### configure Filebeat

# config file
ADD filebeat.yml /etc/filebeat/filebeat.yml

# CA cert
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt

EXPOSE 80 5044

###### start service
ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD ["/usr/local/bin/start.sh"]
