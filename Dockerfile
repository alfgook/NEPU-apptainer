FROM ubuntu:18.04
RUN mkdir -p /home/install
COPY install_all.sh /home/install
COPY startup.sh /home
RUN chmod -R 744 /home/install/install_all.sh
RUN chmod -R 744 /home/startup.sh
RUN /home/install/install_all.sh
ENTRYPOINT /home/startup.sh
CMD interactive
# rstudio server port
EXPOSE 8787
# mongodb server port
EXPOSE 27017
