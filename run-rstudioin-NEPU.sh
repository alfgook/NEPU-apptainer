#!/usr/bin/env bash

# If you want to change the port or the adress uncomment these lines
# export SINGULARITYENV_RSTUDIO_PORT=9090
# export SINGULARITYENV_RSTUDIO_IP=127.0.0.1
# or
# export APPTAINERENV_RSTUDIO_PORT=9090
# export APPTAINERENV_RSTUDIO_IP=127.0.0.1


# temporary directories where rstudio can write files
mkdir -p /tmp/var-lib-rstudio
mkdir -p /tmp/var-run-rstudio

singularity instance start \
	--bind /tmp/var-lib-rstudio:/var/lib/rstudio-server \
	--bind /tmp/var-run-rstudio:/var/run/rstudio-server \
	NEPU-with-rstudio.sif NEPU-rstudio

singularity exec instance://NEPU-rstudio start_rstudio
