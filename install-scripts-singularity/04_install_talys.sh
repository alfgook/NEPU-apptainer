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

    # add read permission to the intup data for all users
    chmod -R ugo+r ./structure

    #chmod 777 "source/talys"
fi

# clone and build runTALYSmpi
#wget -O temp.zip https://github.com/alfgook/runTALYSmpi/archive/refs/heads/c906ddfb2cd236b5f19f80b1ccf215d11c6b32ba.zip
#cd runTALYSmpi-c906ddfb2cd236b5f19f80b1ccf215d11c6b32b
#make
#cp runTALYSmpi /usr/local/bin/
#chmod 755 /usr/local/bin/runTALYSmpi
#cd ..
#rm -r runTALYSmpi-c906ddfb2cd236b5f19f80b1ccf215d11c6b32b
#rm temp.zip