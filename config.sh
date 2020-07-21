##################################################
#       CONFIGURATION VARIABLES
##################################################

# user account inside the container
username="usernamex"
password="password"

# user ID and group ID of the associated
# user account outside the container
extUID=1000
extGID=1000

# path to use for downloaded files
instpath="/home/$username/install"

# url to the talys archive
# if talysurl="", talys will not be downloaded
talysurl="http://www.nucleardata.com/storage/repos/talys/talys1.95.tar"

# installation files to keep

# keep the source code of custom R packages
# after download and installation
keep_Rcodes="yes"

# keep the EXFOR master files after
# they have been fed into the MongoDB database
keep_exfor="no"

savewd=$(pwd)

##################################################
#       SPECIFIC INSTALLATION PATHS 
##################################################

instpath_R="$instpath/Rpackages"
instpath_R2="$instpath/Rcode"
instpath_DL="$instpath/downloads"
instpath_exfor="$instpath/exfor"
instpath_exfor_text="$instpath_exfor/text"

repourl_R="https://cran.rstudio.com"
gitrepo="https://github.com/gschnabel"

