##################################################
#       INSTALL TALYS 
##################################################

if [ ! -z "$talysurl" ]; then
    cd "$instpath"
    wget "$talysurl"
    talys_tarfile=$(basename $talysurl)
    tar --no-same-owner -xf $talys_tarfile
    rm "$talys_tarfile"
    #echo Changing permissions, please be patient...
    #chmod -R 777 "/home/$username/talys"
    #find "/home/$username/talys" -type f -print0 | xargs -0 chmod 666

    #cd "/home/$username/talys"
    cd "talys"
    chmod 777 "talys.setup"

    echo Compiling talys executable...
    sed -i "s/compiler='gfortran'/compiler='gfortran -O2'/" talys.setup
    sed -i "s/\${HOME}/\/usr\/local/g" talys.setup
    ./talys.setup
    echo The error about being unable to move talys to /root/bin is okay
    #chmod 777 "source/talys"
fi
