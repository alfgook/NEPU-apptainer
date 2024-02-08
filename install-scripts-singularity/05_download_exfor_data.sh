##################################################
#       DOWNLOAD THE DATA FROM EXFOR
##################################################

download_exfor() {
    #echo "download of exfor deactivated, reactive in install_all.sh"
    curl -O "$1"
    tar -C text -xf "$(basename "$1")"
}

# install package required for MongoDB EXFOR creation
cd "$instpath_R"
instpkg_cust exforParser 09104fd60025c4d655d7fad1306a2afc2f049c6293136ed4e4a48652f80eba63

# create dirs for EXFOR master files
mkdir "$instpath_exfor"
chmod 777 "$instpath_exfor"
mkdir "$instpath_exfor_text"
chmod 777 "$instpath_exfor_text"
cd "$instpath_exfor"

curl -O https://www-nds.iaea.org/exfor-master/x4toc4/X4-2021-03-08.zip
unzip X4-2021-03-08.zip
rm X4-2021-03-08.zip

# download and prepare the MongoDB EXFOR creation script
chmod 777 "$instpath_R2"

#Rfile="$instpath_R2/createExforDb/create_exfor_mongodb.R"
#download_git_cust createExforDb 10c618b46ef402be1fc82a0e6583ea09fccae23003c23f99b1448fedc027c29f
#chmod -R 777 "$instpath_R2"
#sed -i -e "s|<PATH TO DIRECTORY WITH EXFOR ENTRIES>|$instpath_exfor_text|" "$Rfile"