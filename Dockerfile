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

# make download directory
RUN mkdir -p /home/docker/download

# install openjdk 8
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -qy openjdk-8-jdk

# install the latest python 2.7, python-dev, curl and wget
RUN add-apt-repository ppa:jonathonf/python-2.7
RUN apt-get update
RUN apt-get install -qy git python2.7 python-dev curl wget

# correctly link the cacerts
RUN bash -l -c "/var/lib/dpkg/info/ca-certificates-java.postinst configure"

# download fsqio git repository to the download directory
RUN git clone https://github.com/foursquare/fsqio.git /home/docker/download

# set LANG and LC_ALL to UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# copy over the us-data folder and run.sh script
COPY us-data /home/docker/download/us-data/
COPY run.sh run.sh

# create the FSQIO_BUILD environment/folder/volume
ENV FSQIO_BUILD /home/docker/fsqio
RUN mkdir -p "$FSQIO_BUILD" 
VOLUME $FSQIO_BUILD

# expose the native twofishes ports
EXPOSE 4567 8080 8081

# set the entrypoint
ENTRYPOINT ["/home/docker/run.sh"]
