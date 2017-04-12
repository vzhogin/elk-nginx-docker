FROM ubuntu:14.04
MAINTAINER Omar Ewedah "ewedah88@gmail.com"

#####Install Java 8

RUN apt-get update \
 && apt-get -y install python-software-properties \
 && apt-get -y install software-properties-common \
 && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && add-apt-repository -y ppa:webupd8team/java \
 && apt-get update \
 &&  apt-get install -y oracle-java8-installer \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/cache/oracle-jdk8-installer

#####Install Elasticsearch

RUN apt-get update \
 && apt-get install -y curl \
 && apt-get install -y apt-transport-https \
 && apt-get install -y wget \
 && wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
 && echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list \
 && apt-get update \
 && apt-get -y install elasticsearch 
ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

#####Install Kibana

RUN echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" | tee -a /etc/apt/sources.list.d/kibana-4.4.x.list \
 && apt-get update \
 && apt-get -y install kibana

ADD kibana.yml /opt/kibana/config/kibana.yml

####Install Logstash

RUN echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | tee /etc/apt/sources.list.d/logstash-2.2.x.list \
 && apt-get update \
 && apt-get -y install logstash 
 
#####SSL Certificates
RUN mkdir -p /etc/pki/tls/certs \
 && mkdir /etc/pki/tls/private
ADD logstash-forwarder.crt /etc/pki/tls/certs/
ADD logstash-forwarder.key /etc/pki/tls/private/
 
####Configure Logstash
 
ADD mylogstash.conf /etc/logstash/conf.d/logstash.conf
 

RUN apt-get install -y supervisor
ADD beats-dashboards-1.1.0/ /
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /load.sh
RUN chmod +x /usr/local/bin/start.sh
CMD ["/usr/bin/supervisord"]
EXPOSE 9200 5601 5044 4560/udp
RUN chmod 644 /var/log/*.log
