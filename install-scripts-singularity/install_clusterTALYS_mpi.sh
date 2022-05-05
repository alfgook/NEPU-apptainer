cur_dir=$(pwd)

mytemp=`mktemp -d`
cd "$mytemp"
wget -O temp.zip "https://github.com/alfgook/clusterTALYSmpi/archive/refs/heads/main.zip" # main branch
unzip temp.zip
rm temp.zip
mydir=`ls -1`

R CMD build "$mydir"
rm -r $mydir
myarc=$(ls -1)
R CMD INSTALL "$myarc"

rm -r $mytemp

#first do the make to build the application

mytemp=`mktemp -d`
cd "$mytemp"
wget -O temp.zip "https://github.com/alfgook/runTALYSmpi/archive/refs/heads/main.zip" # main branch
unzip temp.zip
rm temp.zip

mydir=$(ls -1)
cd "$mydir"
make runTALYSmpi
cp runTALYSmpi /usr/local/bin
rm -r $mytemp

cd $cur_dir
#then copy it to /usr/local/bin
