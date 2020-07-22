##################################################
#       INSTALL TALYS 
##################################################

if [ ! -z "$talysurl" ]; then
    cd "$instpath"
    wget "$talysurl"
    talys_tarfile=$(basename $talysurl)
    tar -C "/home/$username/" -xf $talys_tarfile
    rm "$talys_tarfile"
    cd "/home/$username/talys"
    sed -i "s/compiler='gfortran'/compiler='gfortran -O3'/" talys.setup
    echo Compiling talys executable...
    ./talys.setup
fi

