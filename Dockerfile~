FROM ubuntu:18.04

##################################################
#       CONFIGURATION VARIABLES
##################################################

# user account inside the container
ARG username="username"
ARG password="password"

# path to use for downloaded files
ARG instpath="/home/$username/install"

# url to the talys archive
# if talysurl="", talys will not be downloaded
ARG talysurl="http://www.nucleardata.com/storage/repos/talys/talys1.95.tar"

# installation files to keep

# keep the source code of custom R packages
# after download and installation
ARG keep_Rcodes="yes"

# keep the EXFOR master files after
# they have been fed into the MongoDB database
ARG keep_exfor="no"

##################################################
#       SPECIFIC INSTALLATION PATHS 
##################################################

ARG instpath_R="$instpath/Rpackages"
ARG instpath_R2="$instpath/Rcode"
ARG instpath_DL="$instpath/downloads"
ARG instpath_exfor="$instpath/exfor"
ARG instpath_exfor_text="$instpath_exfor/text"

ARG repourl_R="https://cran.rstudio.com"
ARG gitrepo="https://github.com/gschnabel"

# user ID and group ID of the associated
# user account outside the container
ENV extUID=1000
ENV extGID=1000
ENV maxNumCPU=32

##################################################
#       IMAGE BUILDING
##################################################

RUN mkdir -p /home/install

# copy configuration
#COPY config.sh /home/install
#RUN chmod 744 /home/install/config.sh

# copy common functions used in the various steps
COPY rinstall_funs.sh /home/install
RUN chmod 744 /home/install/rinstall_funs.sh

# basic os functionality
COPY 01_install_environment.sh /home/install
RUN chmod 744 /home/install/01_install_environment.sh
RUN /bin/bash -c "source /home/install/01_install_environment.sh"

# install the MongoDB database software
COPY 02_install_mongodb.sh /home/install
RUN chmod 744 /home/install/02_install_mongodb.sh
RUN /bin/bash -c "source /home/install/02_install_mongodb.sh"

# install the R interpreter and R packages required by the pipeline
COPY 03_install_R.sh /home/install
RUN chmod 744 /home/install/03_install_R.sh
RUN /bin/bash -c "source /home/install/rinstall_funs.sh && source /home/install/03_install_R.sh"

# install the nuclear models code Talys
COPY 04_install_talys.sh /home/install
RUN chmod 744 /home/install/04_install_talys.sh
RUN /bin/bash -c "source /home/install/04_install_talys.sh"

# download EXFOR and feed it to the MongoDB database
COPY 05_install_exfor.sh /home/install
RUN chmod 744 /home/install/05_install_exfor.sh
RUN /bin/bash -c "source /home/install/rinstall_funs.sh && source /home/install/05_install_exfor.sh"

# prepare the user account in the container
COPY 06_prepare_user.sh /home/install
RUN chmod 744 /home/install/06_prepare_user.sh
RUN /bin/bash -c "source /home/install/06_prepare_user.sh"

# install custom R packages required by the pipeline
COPY 07_install_custom_packages.sh /home/install
RUN chmod 744 /home/install/07_install_custom_packages.sh
RUN /bin/bash -c "source /home/install/rinstall_funs.sh && source /home/install/07_install_custom_packages.sh"

# install the pipeline itself
COPY 08_install_pipeline.sh /home/install
RUN chmod 744 /home/install/08_install_pipeline.sh
RUN /bin/bash -c "source /home/install/rinstall_funs.sh && source /home/install/08_install_pipeline.sh"

# final actions 
COPY 09_final_actions.sh /home/install
RUN chmod 744 /home/install/09_final_actions.sh
RUN /bin/bash -c "source /home/install/09_final_actions.sh"

# startup options for container
COPY startup.sh /home
RUN /bin/bash -c "sed -i \"s/username/$username/g\" /home/startup.sh"
RUN chmod -R 744 /home/startup.sh
ENTRYPOINT ["/home/startup.sh"]
CMD ["interactive"]

# rstudio server port
EXPOSE 8787
# mongodb server port
EXPOSE 27017
