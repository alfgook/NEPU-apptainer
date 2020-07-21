instpkg_cran() {
    R --no-save -e "install.packages(\"$1\", repos=\"$repourl_R\")"
}


instpkg_cust() {
    git clone "$gitrepo/${1}.git"
    chown -R "$username:$username" $1
    R CMD INSTALL "$1"
}


instpkg_cust_commit() {
    git clone "$gitrepo/${1}.git"
    cd "${1}"
    git checkout "$2"
    git switch -c local_branch
    cd ..
    chown -R "$username:$username" $1
}
