#!/bin/bash

set -e
if [ ! -e "$FSQIO_BUILD/pants.ini" ]; then
	sourceDir="/home/docker/download"
	targetDir="$FSQIO_BUILD"
	cp -a "$sourceDir/." "$targetDir"
fi

cd /home/docker/fsqio
./src/jvm/io/fsq/twofishes/scripts/serve.py -p 8080 us-data/
