FROM ubuntu:18.04
RUN apt-get update && apt-get install -y file && apt-get install -y imagemagick