FROM stackbrew/ubuntu:14.04
MAINTAINER Changbum Hong hongiiv@gmail.com

# Setup a base system
RUN apt-get update && apt-get install -y build-essential zlib1g-dev wget curl python-setuptools git
RUN apt-get install -y openjdk-7-jdk openjdk-7-jre ruby libncurses5-dev libcurl4-openssl-dev libbz2-dev \
    unzip pigz bsdmainutils

# Fake a fuse install; openjdk pulls this in 
# https://github.com/dotcloud/docker/issues/514
# https://gist.github.com/henrik-muehe/6155333
RUN mkdir -p /tmp/fuse-hack && cd /tmp/fuse-hack && \
    apt-get install libfuse2 && \
    apt-get download fuse && \
    dpkg-deb -x fuse_* . && \
    dpkg-deb -e fuse_* && \
    rm fuse_*.deb && \
    echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst && \
    dpkg-deb -b . /fuse.deb && \
    dpkg -i /fuse.deb && \
    rm -rf /tmp/fuse-hack

# bcbio-nextgen install (Automated)
RUN mkdir -p /tmp/bcbio-nextgen-install && cd /tmp/bcbio-nextgen-install && \
    wget --no-check-certificate \
    https://raw.githubusercontent.com/hongiiv/ngspipeline/master/bcbio-nextgen-install.py && \
    python bcbio_nextgen_install.py /usr/local/share/bcbio \
      --nodata --sudo 
