#!/bin/bash

yum install nginx -y >> /tmp/nginx.log
yum install nginx -t 2> /tmp/error.log
yum install nginx -y 2>> /tmp/error.log
yum install nginx -y > /tmp/nginx.log

# > : standard out put and overwrite
# >> : standard out put and append
# 2> : standard error and overwrite
# 2>> : standard error and append
# &> : redirects both std o/p and i/p and overwrites
# &>> : redirects bot std o/p and i/p and appends