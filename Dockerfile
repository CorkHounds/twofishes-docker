# pull base image.
FROM ubuntu:14.04

MAINTAINER Jeremy Glesner "jeremy@corkhounds.com"

# use bash instead of sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update system
RUN apt-get update

# set home directory
ENV FSQIO_BASE /home/docker
WORKDIR /home/docker

# Make download directory
RUN mkdir -p /home/docker/download

RUN apt-get install -qy git

# download fsqio git repository to the download directory
RUN git clone https://github.com/foursquare/fsqio.git /home/docker/download

# copy over the us-data folder and run.sh script
COPY us-data /home/docker/download/us-data/
COPY run.sh run.sh

# create the FSQIO_BUILD environment/folder/volume
ENV FSQIO_BUILD /home/docker/fsqio
RUN mkdir -p "$FSQIO_BUILD" 
VOLUME $FSQIO_BUILD

EXPOSE 4567 8080 8081

ENTRYPOINT ["/home/docker/run.sh"]
