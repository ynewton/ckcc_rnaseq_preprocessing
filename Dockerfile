# CKCC mRNA RNASeq preprocessing pipeline v1.0 docker image
#
# 
# Build with: sudo docker build --force-rm --no-cache -t ynewton/ckcc_rnaseq_preprocessing - < 04_21_16_VARFILTER_Dockerfile
# Run with: sudo docker run -v , <IO_folder>:/home/datadir -i -t ynewton/ckcc_rnaseq_preprocessing —in_file /data/input.tab input.tab -filter_level .2 -out_file /data/test.tab
#
# docker build -t quay.io/hexmap_ucsc/ckcc_rnaseq_preprocessing:1.0 .
# docker run -it -v `pwd`:/home/ubuntu quay.io/hexmap_ucsc/ckcc_rnaseq_preprocessing:1.0 /bin/bash

# Use ubuntu
#FROM ubuntu:14.04
FROM continuumio/anaconda

MAINTAINER Yulia Newton <ynewton@soe.ucsc.edu>

USER root
RUN apt-get -m update && apt-get install -y python wget unzip

COPY round_digits.py /usr/local/bin/
RUN chmod a+x /usr/local/bin/round_digits.py

COPY filter_out_genes_unexpressed_in_most_samples.py /usr/local/bin/
RUN chmod a+x /usr/local/bin/filter_out_genes_unexpressed_in_most_samples.py

COPY filter_out_lowest_varying_genes.py /usr/local/bin/
RUN chmod a+x /usr/local/bin/filter_out_lowest_varying_genes.py

COPY ckcss_preprocessing.1.0.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/ckcss_preprocessing.1.0.sh

RUN chmod -R a+w /usr/local/

# switch back to the ubuntu user so this tool (and the files written) are not owned by root
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

CMD ["/bin/bash"]
