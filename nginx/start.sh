#!/bin/bash

service nginx start
#/tmp/consul-template -consul="kvstore-swarm" -template="/tmp/service.ctmpl:/etc/nginx/conf.d/default.conf:service nginx reload"
