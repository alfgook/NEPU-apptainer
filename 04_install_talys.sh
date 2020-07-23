##################################################
#       INSTALL TALYS 
##################################################

if [ ! -z "$talysurl" ]; then
    cd "$instpath"
    wget "$talysurl"
    talys_tarfile=$(basename $talysurl)
    tar --no-same-owner -C "/home/$username/" -xf $talys_tarfile
    rm "$talys_tarfile"
    chown -R "$username:$username" "/home/$username/talys"
    chmod -R 777 "/home/$username/talys"
    find "/home/$username/talys" -type f -print0 | xargs -0 chmod 666

    cd "/home/$username/talys"
    sed -i "s/compiler='gfortran'/compiler='gfortran -O2'/" talys.setup
    echo Compiling talys executable...
    chmod 777 "talys.setup"
    ./talys.setup
    chmod 777 "source/talys"
fi

