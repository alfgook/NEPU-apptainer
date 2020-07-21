FROM ubuntu:18.04
RUN mkdir -p /home/install

# copy configuration
COPY config.sh /home/install
RUN chmod 744 /home/install/config.sh
COPY common_funs.sh /home/install
RUN chmod 744 /home/install/common_funs.sh

# basic os functionality, rstudio, mongodb 
COPY install_environment.sh /home/install
RUN chmod 744 /home/install/install_environment.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/install_environment.sh"

# install the pipeline itself as additional layer
COPY install_pipeline.sh /home/install
RUN chmod 744 /home/install/install_pipeline.sh
RUN /bin/bash -c "source /home/install/config.sh && source /home/install/common_funs.sh && source /home/install/install_pipeline.sh"

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
