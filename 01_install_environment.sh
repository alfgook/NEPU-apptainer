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

apt install -yq apt-utils
apt install -yq lib32readline7
apt install -yq libxml2
apt install -yq libxml2-dev
apt install -yq libssl-dev
apt install -yq libsasl2-dev
apt install -yq gdebi-core
apt install -yq wget
apt install -yq curl

apt install -yq screen
apt install -yq vim

apt install -yq git
apt install -yq sshpass
apt install -yq rsync
apt install -yq openssh-server

apt install -yq locales
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
