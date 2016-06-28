FROM ubuntu:16.04
MAINTAINER Justifiably <justifiably@ymail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && \
    apt-get install -y software-properties-common

RUN add-apt-repository multiverse && \
    apt-get update -qq && \
    apt-get install -y libdvd-pkg && \
    dpkg-reconfigure libdvd-pkg
    
# Add the PPA and install
RUN add-apt-repository ppa:stebbins/handbrake-releases && \
    apt-get update -qq && \
    apt-get install -y handbrake-cli

# Cleanup
RUN apt-get remove -y software-properties-common && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/media"]
WORKDIR /media

CMD ["/usr/bin/HandBrakeCLI"]
