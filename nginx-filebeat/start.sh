#!/bin/bash

curl -XPUT 'http://172.17.0.1:9200/_template/filebeat?pretty' -d@/etc/filebeat/filebeat.template.json
service filebeat restart

service nginx start
tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log
