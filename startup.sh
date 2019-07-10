#!/bin/bash

service ssh start 
rstudio-server start
mongod --fork --logpath /var/log/mongod.log

export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

/bin/bash
