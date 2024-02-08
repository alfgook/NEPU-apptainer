##################################################
#       INSTALL MongoDB 
##################################################

# export DEBIAN_FRONTEND=noninteractive
# apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
# echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
# apt-get update
# apt-get install -yq \
#     mongodb-org=4.0.20 \
#     mongodb-org-shell=4.0.20 \
#     mongodb-org-server=4.0.20 \
#     mongodb-org-mongos=4.0.20 \
#     mongodb-org-tools=4.0.20

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -yq dirmngr gnupg apt-transport-https ca-certificates software-properties-common
#wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
#echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
apt-get update
apt-get install -yq mongodb-org