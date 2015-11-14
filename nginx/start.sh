#!/bin/bash

cd /tmp
nginx -g "daemon on;"
./consul-template -consul=$KVSTORE -template="/tmp/service.ctmpl:/etc/nginx/conf.d/default.conf:nginx -s reload"
