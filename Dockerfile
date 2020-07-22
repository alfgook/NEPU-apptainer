FROM ubuntu:18.04
RUN mkdir -p /home/install

# copy configuration
COPY config.sh /home/install
RUN chmod 744 /home/install/config.sh

# copy common functions used in the various steps
COPY common_funs.sh /home/install
RUN chmod 744 /home/install/common_funs.sh

# basic os functionality
COPY 01_install_environment.sh /home/install
RUN chmod 744 /home/install/01_install_environment.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/01_install_environment.sh"

# intall custom R packages required by the pipeline
COPY 02_install_mongodb.sh /home/install
RUN chmod 744 /home/install/02_install_mongodb.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/02_install_mongodb.sh"

# install the pipeline itself as additional layer
COPY 03_install_R.sh /home/install
RUN chmod 744 /home/install/03_install_R.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/03_install_R.sh"

# install the pipeline itself as additional layer
COPY 04_install_talys.sh /home/install
RUN chmod 744 /home/install/04_install_talys.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/04_install_talys.sh"

# install the pipeline itself as additional layer
COPY 05_install_exfor.sh /home/install
RUN chmod 744 /home/install/05_install_exfor.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/05_install_exfor.sh"

# install the pipeline itself as additional layer
COPY 06_prepare_user.sh /home/install
RUN chmod 744 /home/install/06_prepare_user.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/06_prepare_user.sh"

# install the pipeline itself as additional layer
COPY 07_install_custom_packages.sh /home/install
RUN chmod 744 /home/install/07_install_custom_packages.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/07_install_custom_packages.sh"

# install the pipeline itself as additional layer
COPY 08_install_pipeline.sh /home/install
RUN chmod 744 /home/install/08_install_pipeline.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/08_install_pipeline.sh"

# install the pipeline itself as additional layer
COPY 09_final_actions.sh /home/install
RUN chmod 744 /home/install/09_final_actions.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/09_final_actions.sh"

# startup options for container
COPY startup.sh /home
RUN /bin/bash -c 'source /home/install/config.sh && sed -i "s/username/$username/g" /home/startup.sh'
RUN chmod -R 744 /home/startup.sh
ENTRYPOINT ["/home/startup.sh"]
CMD ["interactive"]

# rstudio server port
EXPOSE 8787
# mongodb server port
EXPOSE 27017
