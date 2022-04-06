##################################################
#       CONFIGURE OPTIONS
##################################################

mkdir "$HOME/.ssh"
echo "StrictHostKeyChecking=accept-new" >> "$HOME/.ssh/config"
apt update

##################################################
#       CREATE DIRECTORIES
##################################################

mkdir -p "$instpath"
chmod 777 "$instpath"
mkdir "$instpath_DL"
chmod 777 "$instpath_DL"
mkdir "$instpath_R"
chmod 777 "$instpath_R"
mkdir "$instpath_R2"
chmod 777 "$instpath_R2"

##################################################
#       INSTALL BASIC OS PACKAGES
##################################################

export DEBIAN_FRONTEND=noninteractive

apt-get install -yq apt-utils
apt-get install -yq lib32readline7
apt-get install -yq libxml2
apt-get install -yq libxml2-dev
apt-get install -yq libssl-dev
apt-get install -yq libsasl2-dev
apt-get install -yq gdebi-core
apt-get install -yq wget
apt-get install -yq curl

apt-get install -yq screen
apt-get install -yq vim

apt-get install -yq git
apt-get install -yq sshpass
apt-get install -yq rsync
apt-get install -yq openssh-server

apt-get install -yq locales
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
