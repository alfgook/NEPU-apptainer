##################################################
#       INSTALL R AND REQUIRED R PACKAGES
##################################################

export DEBIAN_FRONTEND=noninteractive
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "deb [ arch=amd64 ] https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | tee /etc/apt/sources.list.d/r-project-3.5.list
apt-get update
apt-get install -yq r-base=3.6.3-1bionic

cd "$instpath_R"

# install packages available on cran

instpkg_cran data.table
instpkg_cran Rcpp
instpkg_cran mongolite
instpkg_cran digest
instpkg_cran ggplot2
instpkg_cran mvtnorm
instpkg_cran hetGP
instpkg_cran optimParallel

if [ "$keep_Rcodes" != "yes" ]; then
    rm -rf "$instpath_R"
fi

# install Rstudio

cd "$instpath_DL"
wget "https://download2.rstudio.org/rstudio-server-1.1.463-amd64.deb"
gdebi --n "rstudio-server-1.1.463-amd64.deb"
rm "rstudio-server-1.1.463-amd64.deb"

