#!/bin/bash

if [ -d "$1" ]
then
	db_dir="$1/db"
	log_dir="$1/log"
	
	mongod --fork --logpath $log_dir/mongod.log --dbpath $db_dir

else
	echo "Error: $dir not found. You must provide a valid directory were the database is located."
fi

