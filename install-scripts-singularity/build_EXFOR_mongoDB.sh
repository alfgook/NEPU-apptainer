#!/bin/bash

if [ -d "$1" ]
then
	source $instpath/rinstall_funs.sh
	# start the mongodb server
	db_dir="$1/db"
	log_dir="$1/log"
	mkdir -p $log_dir
	mkdir $db_dir
	# add some checking that the directories do not already exist to avoid that we recreate the database

	mongod --fork --logpath $log_dir/mongod.log --dbpath $db_dir

	#run MongoDB EXFOR creation script
	Rfile="$instpath_R2/createExforDb/create_exfor_mongodb.R"
	Rscript --no-save --vanilla "$Rfile" $instpath_exfor/X4all
else
	echo "Error: $dir not found or is symlink to $(readlink -f ${dir}). You must provide a valid directory to place the data base in."
fi

