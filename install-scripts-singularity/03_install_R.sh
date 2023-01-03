##################################################
#       INSTALL R AND REQUIRED R PACKAGES
##################################################

# for ubuntu 20.04
#export DEBIAN_FRONTEND=noninteractive
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
#echo "deb [ arch=amd64 ] https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" | tee /etc/apt/sources.list.d/r-project-3.5.list
#apt-get update
#apt-get install -yq r-base=4.1.3-1.2004.0

#for ubuntu 18.04
#export DEBIAN_FRONTEND=noninteractive
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
#echo "deb [ arch=amd64 ] https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | tee /etc/apt/sources.list.d/r-project-3.5.list
#apt-get update
#apt-get install -yq r-base=3.6.3-1bionic

#for ubuntu 22.04

#apt-get update -qq
## install two helper packages we need
#apt-get install -yq --no-install-recommends software-properties-common dirmngr
## add the signing key (by Michael Rutter) for these repos
## To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
## Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
#wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
#add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
#apt-get update
#apt-get install -yq --no-install-recommends r-base=4.2.2.20221110-1.2204.0

# for ubuntu 22.04
export DEBIAN_FRONTEND=noninteractive
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "deb [ arch=amd64 ] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" | tee /etc/apt/sources.list.d/r-project-4.2.list
apt-get update
apt-get install -yq r-base=4.2.2.20221110-1.2204.0


cd "$instpath_R"

# install packages available on cran

instpkg_cran data.table
instpkg_cran Rcpp
instpkg_cran mongolite
instpkg_cran digest
instpkg_cran ggplot2
instpkg_cran mvtnorm
instpkg_cran hetGP
instpkg_cran stringr
instpkg_cran moments

if [ "$keep_Rcodes" != "yes" ]; then
    rm -rf "$instpath_R"
fi

# install Rstudio

#cd "$instpath_DL"
#wget "https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb"
#gdebi --n "rstudio-server-1.1.463-amd64.deb"
#rm "rstudio-server-1.1.463-amd64.deb"

