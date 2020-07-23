instpkg_cran() {
    R --no-save -e "install.packages(\"$1\", repos=\"$repourl_R\")"
}


instpkg_cust() {
    git clone "$gitrepo/${1}.git"
    chmod -R 777 $1
    R CMD INSTALL "$1"
}


instpkg_cust_commit() {
    git clone "$gitrepo/${1}.git"
    cd "${1}"
    git checkout "$2"
    git branch local_branch
    git checkout local_branch
    cd ..
    chmod -R 777 $1
}
