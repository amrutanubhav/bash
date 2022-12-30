#!/bin/bash

yum install -y >> /tmp/nginx.log
sudot 2> /tmp/error.log


# > : standard out put and overwrite
# >> : standard out put and append
# 2> : standard error and overwrite
# 2>> : standard error and append
# &> : redirects both std o/p and i/p and overwrites
# &>> : redirects bot std o/p and i/p and appends
# < : input redirection