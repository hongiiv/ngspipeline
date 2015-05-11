#!/bin/bash
#set -eu -o pipefail

# Run workflow
cd /bio
DATE=`date +%Y-%m-%d`
mkdir -p workflow-${DATE}/config workflow-${DATE}/input workflow-${DATE}/work
cd workflow-${DATE}/config
wget https://raw.githubusercontent.com/chapmanb/bcbio-nextgen/master/config/examples/cancer-dream-syn3.yaml

rm -rf /usr/local/share/bcbio/genomes
rm -rf /usr/local/share/bcbio/galaxy

cd /usr/local/share/bcbio
ln -s /bio/galaxy ./galaxy
ln -s /bio/genomes ./genomes

wget --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/genome.py
mv genome.py /usr/local/share/bcbio/anaconda/lib/python2.7/site-packages/bcbio/pipeline/genome.py

# Exome only data
cd /bio/workflow-${DATE}/input
wget --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/synthetic_challenge_set3_normal_NGv3_1.fq.gz
wget --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/synthetic_challenge_set3_normal_NGv3_2.fq.gz
wget --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/synthetic_challenge_set3_tumor_NGv3_1.fq.gz
wget --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/synthetic_challenge_set3_tumor_NGv3_2.fq.gz

# Evaluation data and BED files
wget --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/synthetic_challenge_set3_tumor_20pctmasked_truth.tar.gz
tar -xzvpf synthetic_challenge_set3_tumor_20pctmasked_truth.tar.gz
wget -O refseq-merged.bed.gz --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/refseq-merged.bed.gz
wget -O NGv3.bed.gz --no-check-certificate https://ssproxy.ucloudbiz.olleh.com/v1/AUTH_f1b97694-00cd-4e06-b9f3-30a0f9d01f66/bcbio/NGv3.bed.gz
gunzip *.bed.gz

cd /bio/workflow-${DATE}/work
bcbio_nextgen.py ../config/cancer-dream-syn3.yaml -n 8
