# cudnn-caffe
Dockerfile for cudnn based caffe

Steps:
1. Add cuddn.tgz (https://developer.nvidia.com/cudnn) to project root.

2. Build docker image (```docker run build -t cudnn-caffe```)

3. Run docker container with nvidia devices mounted: 
  
  ```docker run -it -v /opt/data:/opt/data --device /dev/nvidiactl --device /dev/nvidia0 cudnn-caffe```
4. re-install cuda (following recomedations from http://tleyden.github.io/blog/2015/11/22/running-neural-style-on-an-aws-gpu-instance):
  
  ```bash
  wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb
  sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y opencl-headers build-essential protobuf-compiler \
    libprotoc-dev libboost-all-dev libleveldb-dev hdf5-tools libhdf5-serial-dev \
    libopencv-core-dev  libopencv-highgui-dev libsnappy-dev libsnappy1 \
    libatlas-base-dev cmake libstdc++6-4.8-dbg libgoogle-glog0 libgoogle-glog-dev \
    libgflags-dev liblmdb-dev git python-pip gfortran
  sudo apt-get clean
  sudo apt-get install -y linux-image-extra-`uname -r` linux-headers-`uname -r` linux-image-`uname -r`
  sudo apt-get install -y cuda
  ```
  If you encounter the error like this: "error while loading shared libraries: libcudart.so.7.5" run the following commands:
  ```bash
  export PATH=$PATH:/usr/local/cuda-7.5/bin
  export LD_LIBRARY_PATH=:/usr/local/cuda-7.5/lib64
  sudo ldconfig
  ```
5. Run caffe
