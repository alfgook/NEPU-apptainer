##################################################
#       DOWNLOAD THE PIPELINE 
##################################################

# install custom packages not on cran

cd "$instpath_R"
instpkg_cust interactiveSSH
instpkg_cust rsyncFacility
instpkg_cust remoteFunctionSSH
instpkg_cust clusterSSH

instpkg_cust exforParser
instpkg_cust MongoEXFOR
instpkg_cust jsonExforUtils
instpkg_cust talysExforMapping
instpkg_cust TALYSeval
instpkg_cust exforUncertainty
instpkg_cust nucdataBaynet

instpkg_cust clusterTALYS

cd "/home/$username"
instpkg_cust_commit eval-fe56 c3dc58a303afcba7a47637190331f42321065f9b

# function to update the paths in the config file
update_config() {
  sed -i 's/ssh_login *<- *"[^"]*"/ssh_login <- "'"${username}"'@localhost"/' "$1"
  sed -i 's/ssh_pw *<- *"[^"]*"/ssh_pw <- "'"${password}"'"/' "$1"
  sed -i 's/calcdir_loc *<- *"[^"]*"/calcdir_loc <- "\/home\/'"$username"'\/calcdir"/' "$1"
  sed -i 's/calcdir_rem *<- *"[^"]*"/calcdir_rem <- "\/home\/'"$username"'\/remcalcdir"/' "$1"
  sed -i 's/rootpath *<- *"[^"]*"/rootpath <- "\/home\/'"$username"'\/eval-fe56"/' "$1"
  sed -i 's/savePathTalys *<- *"[^"]*"/savePathTalys <- "\/home\/'"$username"'\/talysResults"/' "$1"
  sed -i 's/\(initClusterTALYS(.*, *talysExe *= *"\)[^"]*\(",.*\)$/\1'"\\/home\\/$username\\/talys\\/source\\/talys"'\2/' "$1" 
}
# update paths in the config files
update_config "eval-fe56/config.R"
update_config "eval-fe56/config.R.fulleval"
sed -i 's/setwd("[^"]*")/setwd("\/home\/'"$username"'\/eval-fe56")/' "eval-fe56/run_pipeline.R"

# create an exemplary calculation directory
cd "/home/$username"
mkdir "calcdir"
mkdir "remcalcdir"
mkdir "talysResults"
chown "$username:$username" calcdir remcalcdir talysResults  

if [ "$keep_Rcodes" != "yes" ]; then
    rm -rf "$instpath_R"
    rm -rf "$instpath_R2"
fi

