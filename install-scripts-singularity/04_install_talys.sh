##################################################
#       INSTALL TALYS 
##################################################

if [ ! -z "$talysurl" ]; then
    cd "$instpath"
    wget "$talysurl"
    talys_tarfile=$(basename $talysurl)
    tar --no-same-owner -xf $talys_tarfile
    rm "$talys_tarfile"
    cd "talys"

    # add read permission to the intup data for all users
    chmod -R ugo+r ./structure
    
fi
