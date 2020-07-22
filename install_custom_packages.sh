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

if [ "$keep_Rcodes" != "yes" ]; then
    rm -rf "$instpath_R"
    rm -rf "$instpath_R2"
fi
