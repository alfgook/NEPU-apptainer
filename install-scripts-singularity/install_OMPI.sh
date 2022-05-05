echo "Installing required packages..."
#apt-get update && apt-get install -y make file

echo "Installing Open MPI"
export OMPI_URL="https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-$OMPI_VERSION.tar.bz2"
mkdir -p /tmp/ompi
mkdir -p /opt
# Download
cd /tmp/ompi && wget --no-check-certificate -O openmpi-$OMPI_VERSION.tar.bz2 $OMPI_URL && tar -xjf openmpi-$OMPI_VERSION.tar.bz2
# Compile and install
cd /tmp/ompi/openmpi-$OMPI_VERSION && ./configure --prefix=$OMPI_DIR && make -j8 install

rm -r /tmp/ompi

# Set env variables so we can compile our application
# this needs to be done in the def file
#export PATH=$OMPI_DIR/bin:$PATH
#export LD_LIBRARY_PATH=$OMPI_DIR/lib:$LD_LIBRARY_PATH