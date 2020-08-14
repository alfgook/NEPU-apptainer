### Dockerfile for Fe56 evaluation pipeline

This repository contains a Dockerfile for the
creation of a Docker image with all required
dependencies to run the pipeline for the
evaluation of neutron-induced reactions of
Fe56 available at
<https://github.com/gschnabel/eval-fe56>.

The manual available [here](https://github.com/gschnabel/eval-fe56-docker/raw/master/manual/build/manual.pdf)
provides installation instructions and further details
regarding the evaluation pipeline.

If you are already familiar with Docker, you may just jump into exploring the pipeline:
```
docker run --rm -it -p 9090:8787 --name eval-fe56-cont eval-fe56-img interactive
```

Now you can use command line tools to poke aorund.
The manual provides more details on the directory structure inside the container.
Alternatively, you can open a web browser and go to <http://localhost:9090>
and use `username` and `password` as username and password.

To run a small test evaluation, you can run
```
docker run --rm -it -p 9090:8787 --name eval-fe56-cont eval-fe56-img test_eval
```
This will take ten minutes and results will be stored inside the container.
To see which files have been produced, type
```
docker start eval-fe56-cont
docker exec -it eval-fe56-cont /bin/bash
```
TALYS results are available as tar archives in `/home/username/talysResults`.
Afterwards, you can type `exit` to stop the container and remove it
by typing
```
docker rm eval-fe56-cont
```

Better yet, for the persistency of the results, if you create two folders 
with their absolute paths denoted by `<talysResults>` and `<outdata>` for
the results.
Determine your user id `<UID>` and group id `<GID>`, e.g., 
by `cat /etc/passwd | grep <your username>`.
Now you can run the test evaluation and have the results stored outside the
container by running:
```
docker run -it -p 9090:22 \
           -v <outdata>:/home/username/eval-fe56/outdata \
           -v <talysResults>:/home/username/talysResults \
           -v /dev/shm:/dev/shm \
           -e extUID=<UID> -e extGID=<GID> \
           --name eval-fe56-cont eval-fe56-img test_eval
```

Talys result files packed as tar files should have been produced in `<talysResults>`
and folders numbered from `01` to `09` in `<outdata>`.
If everything worked and you have 80 cores and about 40 GBytes of main memory 
and are willing to wait 12 hours,
you can also replace `test_eval` by `full_eval` to perform the full scale
evaluation of Fe56.

If something goes wrong, you can kill the running calculations by
```
docker stop eval-fe56-cont
```
And also permanently remove the container by typing
```
docker rm eval-fe56-cont
```
Note, however, that result files will be preserved in folders
`<outdata>` and `<talysResults>` on your filesystem.


