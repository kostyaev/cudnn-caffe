FROM kaixhin/cuda:latest
MAINTAINER Dmitry Kostyaev <dmitry@kostyaev.me>

RUN apt-get update && apt-get install -y \
  git \
  bc \
  libatlas-base-dev \
  libatlas-dev \
  libboost-all-dev \
  libopencv-dev \
  libprotobuf-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  protobuf-compiler \
  libhdf5-dev \
  libleveldb-dev \
  liblmdb-dev \
  libsnappy-dev

ADD cudnn.tgz /tmp/
RUN cd /tmp/cuda && \
sudo cp lib64/* /usr/local/cuda/lib64/ && \
sudo cp include/cudnn.h /usr/local/cuda/include/ && \
sudo rm -r /tmp/cuda

RUN cd /opt && git clone https://github.com/BVLC/caffe.git
ADD Makefile.config /opt/caffe/
RUN cd /opt/caffe && make -j8 all
WORKDIR /opt/caffe