### Apptainer/Singularity definition file for Fe56 evaluation pipeline

This repository contains an Apptainer definition file for the
creation of an Apptainer container with all required
dependencies to run the pipeline for the
evaluation of neutron-induced reactions of
Fe56 available at
<https://github.com/gschnabel/eval-fe56>.

The manual available [here](https://github.com/gschnabel/eval-fe56-docker/raw/master/manual/build/manual.pdf)
provides installation instructions and further details
regarding the evaluation pipeline. These are however largely outdated.

If you are already familiar with Apptainer/singularity, you may just jump into exploring the pipeline.
Clone this repository and then create the Docker image by launching from inside the repository folder:
```
apptainer build --fakeroot eval-fe56.sif eval-fe56.def
```

The most up to date version of the definition file is eval-for-rackham.def which builds a version
which can be run either locally (tested on a laptop running Ubuntu 20.04.6-LTS) or an HPC cluster
(tested on the rackham cluster at UPPMAX).

The git repo contains a number of branches, the most up to date development branch is rackham

During the image building process, several components, such as the nuclear model code TALYS,
and (a not up-to-date version of) the EXFOR library, are downloaded.
The final size of the image is about 9 GBytes and depending on your internet speed
you can anticipate the building process to take 30-60 minutes.


To create a container and to launch an interactive terminal session inside, execute:
```
apptainer shell eval-fe56.sif
```

Now you can use command line tools to poke aorund.
The manual provides more details on the directory structure inside the container.


The full evaluation takes significant time and resources.  Please ensure that `<outdata>` and
`<talysResults>` are empty directories and do not contain the results of
a previous pipeline run. Furthermore, it is important to adjust the variable
`maxNumCPU` according to your hardware by considering the following:

- `/dev/shm` is used as temporary storage of TALYS result files. One TALYS
  calculation stores up to 150 MB worth of files. The value of `maxNumCPU`
  determines the number of calculations run in parallel. Set `maxNumCPU` so
  that the storage need does not exceed the capacity of `/dev/shm`.
- Each TALYS calculation requires about 0.8 GB of main memory, which should
  be equally taken into account to avoid running out of main memory.

To give some reference, the pipeline with `maxNumCPU=32` uses up to 3 GB
of `/dev/shm` and up to 23 GB of main memory. On our cluster, the pipeline
run through in about 16 hours.
