#!/usr/bin/env bash

read -sp "set password for rstudio session: " password
echo ""

length=${#password}
while [ $length -lt 4 ]; do
	read -sp "password should be at least 4 characters long: " password
	echo ""
	length=${#password}
done

export RSTUDIO_PASSWORD=${password}

nohup rserver --auth-none 0  --auth-pam-helper rstudio_auth > /dev/null 2>&1 < /dev/null &