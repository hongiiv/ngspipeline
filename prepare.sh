#!/bin/bash
#set -eu -o pipefail

# This script run at free disk space large then 20 GB
# Full input data
mkdir -p /bio
cd /bio
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzaa
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzab
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzac
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzad
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzae
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzaf
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzag
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzah
wget --no-check-certificat https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genomes.tar.gzai
cat genomes.tar.gz* | tar xvfz -
rm -rf galaxy.tar.gz genomes.bwa.tar.gz genomes.seq.tar.gz genomes.variation.tar.gz

# Setup base system
apt-get update -y && apt-get install linux-image-generic-lts-trusty -y
wget --no-check-certificat -qO- https://get.docker.com/ | sh

# Docker run
docker pull hongiiv/bcbio:0.2
docker run -t -i -v /bio:/bio hongiiv/bcbio:0.2 /bin/bash
