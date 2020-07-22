##################################################
#       CONFIGURE OPTIONS
##################################################

export DEBIAN_FRONTEND=noninteractive
mkdir "$HOME/.ssh"
echo "StrictHostKeyChecking=accept-new" >> "$HOME/.ssh/config"
apt update

##################################################
#       CREATE DIRECTORIES
##################################################

mkdir -p "$instpath"
mkdir "$instpath_DL"
mkdir "$instpath_R"
mkdir "$instpath_R2"

##################################################
#       INSTALL BASIC OS PACKAGES
##################################################

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

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "deb [ arch=amd64 ] https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | tee /etc/apt/sources.list.d/r-project-3.5.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
apt update

apt install -yq mongodb-org
apt install -yq r-base

##################################################
#       INSTALL REQUIRED R PACKAGES
##################################################

cd "$instpath_R"

# install packages available on cran

instpkg_cran data.table
instpkg_cran Rcpp
instpkg_cran mongolite
instpkg_cran digest
instpkg_cran ggplot2
instpkg_cran mvtnorm

# install package required for MongoDB EXFOR creation
instpkg_cust exforParser

# install Rstudio

cd "$instpath_DL"
wget "https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb"
gdebi --n "rstudio-server-1.1.463-amd64.deb"

##################################################
#       INSTALL TALYS 
##################################################

if [ ! -z "$talysurl" ]; then
    cd "$instpath"
    wget "$talysurl"
    talys_tarfile=$(basename $talysurl)
    tar -C "/home/$username/" -xf $talys_tarfile
    rm "$talys_tarfile"
    cd "/home/$username/talys"
    sed -i "s/compiler='gfortran'/compiler='gfortran -O3'/" talys.setup
    echo Compiling talys executable...
    ./talys.setup
fi

##################################################
#       SET UP THE MONGODB DATABASE
##################################################

download_exfor() {
    #echo "download of exfor deactivated, reactive in install_all.sh"
    curl -O "$1"
    tar -C text -xf "$(basename "$1")"
}

mkdir "$instpath_exfor"
mkdir "$instpath_exfor_text"
cd "$instpath_exfor"

download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_10001-10535.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_10536-11690.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_11691-13569.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_13570-13768.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_13769-14239.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_14240-20118.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_20119-21773.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_21774-22412.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_22413-22921.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_22922-23129.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_23130-23250.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_23251-23324.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_23325-23415.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_23416-A0099.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_A0100-C1030.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_C1031-D0487.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_D0488-E1841.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_E1842-F1045.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_F1046-O0678.tar.xz"
download_exfor "http://www.nucleardata.com/storage/repos/exfor/entries_O0679-V1002.tar.xz"

# populate the database

mkdir -p "/data/db"
mkdir "$instpath_R2"
cd "$instpath_R2"

# start the mongodb server
mongod --fork --logpath /var/log/mongod.log

Rfile="$instpath_R2/createExforDb/create_exfor_mongodb.R"
git clone https://github.com/gschnabel/createExforDb.git
sed -i -e "s|<PATH TO DIRECTORY WITH EXFOR ENTRIES>|$instpath_exfor_text|" "$Rfile"
Rscript --no-save --vanilla "$Rfile" 

##################################################
#       CREATE USERDIR FOR PIPELINE 
##################################################

# create user and their home directory
useradd "$username" 
echo "$username:$password" | chpasswd
mkdir "/home/$username"

# enable new ssh connection without authenticity warning
mkdir "/home/$username/.ssh"
chmod 700 "/home/$username/.ssh"
echo "StrictHostKeyChecking=accept-new" >> "/home/$username/.ssh/config"
chmod 400 "/home/$username/.ssh/config"

# enable password-less ssh within the container
ssh-keygen -t rsa -N "" -f "/home/$username/.ssh/id_rsa"
cat "/home/$username/.ssh/id_rsa.pub" >> "/home/$username/.ssh/authorized_keys" 
chmod 600 "/home/$username/.ssh/id_rsa.pub"
chmod 600 "/home/$username/.ssh/authorized_keys"

##################################################
#       FINAL ACTIONS
##################################################

# delete installation files
rm -rf "$instpath_DL"
rm -rf "$instpath/talys.tar"
if [ "$keep_exfor" != "yes" ]; then
    rm -rf "$instpath_exfor"
else
    mv "$instpath_exfor_text" "$instpath/exfortmp"
    rm -rf "$instpath_exfor"
    mv "$instpath/exfortmp" "$instpath_exfor"
fi

# make the user owner of their home directory
echo Setting ownership of files in user home directory...
chown -R "$username:$username" "/home/$username"
# make the user owner of the installation files
echo Setting ownership of installation files...
chown -R "$username:$username" "$instpath"

# map the user in the container to some external user
sed -i "s/^$username:x:[0-9]\+:[0-9]\+/$username:x:$extUID:$extGID/" /etc/passwd

# set bash as default shell for the user
chsh --shell /bin/bash "$username"

