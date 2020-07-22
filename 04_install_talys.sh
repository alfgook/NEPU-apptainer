##################################################
#       INSTALL TALYS 
##################################################

if [ ! -z "$talysurl" ]; then
    cd "$instpath"
    wget "$talysurl"
    talys_tarfile=$(basename $talysurl)
    tar --no-same-owner -C "/home/$username/" -xf $talys_tarfile
    chown -R "$username:$username" "/home/$username/talys"
    rm "$talys_tarfile"
    cd "/home/$username/talys"
    sed -i "s/compiler='gfortran'/compiler='gfortran -O2'/" talys.setup
    echo Compiling talys executable...
    ./talys.setup
fi

