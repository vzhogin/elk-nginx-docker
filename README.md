# Docker ELK stack and nginx webserver

Run the latest version of the ELK (Elasticseach, Logstash, Kibana) stack and nginx with Docker and Docker-compose.

The task is to build a web server serving any web application and send the web server logs to elasticsearch.

Based on the official images:

* [elasticsearch](https://registry.hub.docker.com/_/elasticsearch/)
* [logstash](https://registry.hub.docker.com/_/logstash/)
* [kibana](https://registry.hub.docker.com/_/kibana/)
* [nginx](https://registry.hub.docker.com/_/nginx/)

# Requirements

## Setup

1. Install [Docker](http://docker.io).
2. Install [Docker-compose](http://docs.docker.com/compose/install/) **version >= 1.6**.
3. Clone this repository

## Increase max_map_count on your host (Linux)

You need to increase `max_map_count` on your Docker host:

```bash
$ sudo sysctl -w vm.max_map_count=262144
```

# Usage

Start the ELK stack and nginx using *docker-compose*:

```bash
$ docker-compose up
```

You can also choose to run it in background (detached mode):

```bash
$ docker-compose up -d
```

Now that the stack and nginx are running

And then access Kibana UI by hitting [http://localhost:5601](http://localhost:5601) with a web browser.

And then access Nginx by hitting [http://localhost:80](http://localhost:80) with a web browser.


By default, the stack exposes the following ports:
* 5044: Filebeat.
* 9200: Elasticsearch HTTP
* 5601: Kibana
* 80: Nginx

*WARNING*: If you're using *boot2docker*, you must access it via the *boot2docker* IP address instead of *localhost*.

*WARNING*: If you're using *Docker Toolbox*, you must access it via the *docker-machine* IP address instead of *localhost*.

# Configuration

*NOTE*: Configuration is not dynamically reloaded, you will need to restart the stack after any change in the configuration of a component.

## How can I tune Kibana configuration?

The Kibana default configuration is stored in `kibana/config/kibana.yml`.

## How can I tune Logstash configuration?

The logstash configuration is stored in `logstash/config/logstash.conf`.

The folder `logstash/config` is mapped onto the container `/etc/logstash/conf.d` so you
can create more than one file in that folder if you'd like to. However, you must be aware that config files will be read from the directory in alphabetical order.

## How enable Nginx compression?

The nginx configuration is stored in `/etc/nginx/nginx.conf`.

## How enable Nginx caching?

The nginx caching configuration is stored in `/etc/nginx/conf.d/default.conf`.

## How configure Filebeat?  [filebeat](https://www.elastic.co/products/beats/filebeat)

The filebeat configuration is stored in `/etc/filebeat/filebeat.yml`.

