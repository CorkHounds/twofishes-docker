#!/bin/bash

# exit the shell if any action returns a non-zero status.
set -e

# if the build directory doesn't contain pants.ini, create it
# this will copy the FSQIO repo to persistent volume
if [ ! -e "$FSQIO_BUILD/pants.ini" ]; then
	sourceDir="/home/docker/download"
	targetDir="$FSQIO_BUILD"
	cp -a "$sourceDir/." "$targetDir"
fi

# change to the fsqio directory
cd /home/docker/fsqio

# initialize twofishes service
./src/jvm/io/fsq/twofishes/scripts/serve.py -p 8080 us-data/
