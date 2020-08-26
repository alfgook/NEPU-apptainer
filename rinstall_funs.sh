instpkg_cran() {
    R --no-save -e "install.packages(\"$1\", repos=\"$repourl_R\")"
}


instpkg_cust() {
    curdir=`pwd`
    mytemp=`mktemp -d`
    cd "$mytemp"
    wget -O temp.zip "http://nugget.link/$2/zip"
    unzip temp.zip
    rm temp.zip
    mydir=`ls -1`
    if [[ "$mydir" == "$1"* ]]; then
        R CMD INSTALL "$mydir"
        mypath="`pwd`/$mydir"
        cd "$curdir"
        cp -r "$mypath" "$1" 
    else
        echo "ERROR: could not install package $1"
    fi 
    rm -r "$mytemp"
    cd "$curdir"
}


download_git_cust() {
    curdir=`pwd`
    mytemp=`mktemp -d`
    cd "$mytemp"
    wget -O temp.zip "http://nugget.link/$2/zip"
    unzip temp.zip
    rm temp.zip
    mydir=`ls -1`
    if [[ "$mydir" == "$1"* ]]; then
        mypath="`pwd`/$mydir"
        cd "$curdir"
        mv "$mypath" "$1"  
    else
        echo "ERROR: could not download git repo $1"
    fi 
    rm -r "$mytemp"
    cd "$curdir"
}
