##################################################
#       INSTALL R AND REQUIRED R PACKAGES
##################################################

# for ubuntu 20.04
export DEBIAN_FRONTEND=noninteractive
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
echo "deb [ arch=amd64 ] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" | tee /etc/apt/sources.list.d/r-project-4.2.list
apt-get update
apt-get install -yq r-base=4.2*


cd "$instpath_R"

# install packages available on cran
# R packages should be installed into "/usr/lib/R/site-library" or "/usr/lib/R/library" to be
# reachable when the --vanilla flag is passed to R or Rscript

instpkg_cran data.table
instpkg_cran Rcpp
instpkg_cran mongolite
instpkg_cran digest
instpkg_cran ggplot2
instpkg_cran ggnewscale
instpkg_cran mvtnorm
instpkg_cran hetGP
instpkg_cran stringr
instpkg_cran moments
instpkg_cran optimParallel
instpkg_cran mvnfast
instpkg_cran latex2exp
instpkg_cran ggridges
instpkg_cran reshape2
instpkg_cran gplots
R --no-save -e "install.packages(\"Rmpi\", repos=\"$repourl_R\", lib=\"/usr/lib/R/site-library\", configure.args=c(\"--with-Rmpi-include=$OMPI_DIR/include\",\"--with-Rmpi-libpath=$OMPI_DIR/lib\",\"--with-Rmpi-type=OPENMPI\"))"

if [ "$keep_Rcodes" != "yes" ]; then
    rm -rf "$instpath_R"
fi

# install Rstudio

export RSTUDIO_VERSION=1.2.5033
# this version of rstudio-server depends on a deprecated package
# I don't manage to get newer versions of rstudio-server to run on
# the read only file-system

# wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
# apt-get install ./libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
# rm -f libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb
# 
# cd "$instpath_DL"
# wget \
#     --no-verbose \
#     -O rstudio-server.deb \
#     "https://download2.rstudio.org/server/trusty/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb"
#   gdebi -n rstudio-server.deb
#   rm -f rstudio-server.deb