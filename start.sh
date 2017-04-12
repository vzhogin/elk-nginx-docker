#!/bin/bash
#
# /usr/local/bin/start.sh
# Start Elasticsearch, Logstash and Kibana services


service elasticsearch start

#wait for elasticsearch to start up - https://github.com/elasticsearch/kibana/issues/3077
counter=0
while [ ! "$(curl 172.17.0.1:9200 2> /dev/null)" -a $counter -lt 130  ]; do
  sleep 1
  ((counter++))
  echo "waiting for Elasticsearch to be up ($counter/130)"
done

service logstash start

service kibana start

/opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf

