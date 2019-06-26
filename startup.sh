#!/bin/bash

service ssh start 
rstudio-server start
mongod --fork --logpath /var/log/mongod.log
/bin/bash
