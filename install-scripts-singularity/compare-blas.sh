#! bin/bash

# standard blas
echo "---- default ubuntu BLAS -----"
update-alternatives --set liblapack.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3
update-alternatives --set libblas.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/blas/libblas.so.3
echo "------------------------------"

Rscript --vanilla /usr/local/bin/test_blas.R

# ATLAS
echo "---- ATLAS -------------"
update-alternatives --set liblapack.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/atlas/liblapack.so.3
update-alternatives --set libblas.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/atlas/libblas.so.3
echo "------------------------"

Rscript --vanilla /usr/local/bin/test_blas.R

# openblas-pthread
echo "---- openblas-pthread BLAS ----"
update-alternatives --set liblapack.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openblas-pthread/liblapack.so.3
update-alternatives --set libblas.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3
echo "-------------------------------"

Rscript --vanilla /usr/local/bin/test_blas.R

# openblas-openmp
echo "---- openblas-openmp BLAS ----"
update-alternatives --set liblapack.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openblas-openmp/liblapack.so.3
update-alternatives --set libblas.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openblas-openmp/libblas.so.3
echo "------------------------------"

Rscript --vanilla /usr/local/bin/test_blas.R

# openblas-serial
echo "---- openblas-serial BLAS ----"
update-alternatives --set liblapack.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openblas-serial/liblapack.so.3
update-alternatives --set libblas.so.3-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openblas-serial/libblas.so.3

Rscript --vanilla /usr/local/bin/test_blas.R
echo "------------------------------"