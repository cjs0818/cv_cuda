#--------------------
# For CUDA
#FROM jschoi/yolo
FROM nvidia/cuda
#RUN ls -al
#--------------------


# install ros packages
#RUN apt-get update && apt-get install -y \
#    ros-kinetic-desktop-full=1.3.1-0* \
#    && rm -rf /var/lib/apt/lists/*

# install vim
#RUN apt-get update && apt-get install -y \
#    vim \
#    wget \
#    x11-apps \
#    && rm -rf /var/lib/apt/lists/*

# generate /root/work directory
WORKDIR /root/work

# copy .bashrc from host to target /root directory
ADD .bashrc /root

# setup environment variables?
ENV DISPLAY :0

#--------------------------------
#RUN echo 'alias so="source ~/.bashrc"' >> ~/.bashrc
#RUN echo 'alias ll="ls -al"' >> ~/.bashrc
#CMD {"echo","'alias ll="ls -al"' >> ~/.bashrc"}
#RUN echo 'source /opt/ros/$ROS_DISTRO/setup.bash' >> ~/.bashrc

#RUN cd /root; git clone https://github.com/AlexeyAB/darknet
#RUN cd /root/darknet; make


# You need the following files
#RUN cd /root/darknet; wget https://pjreddie.com/media/files/yolo.weights
#RUN cd /root/darknet; wget https://pjreddie.com/media/files/yolo-voc.weights
#RUN cd /root/darknet; wget https://pjreddie.com/media/files/tiny-yolo.weights
#RUN cd /root/darknet; wget https://pjreddie.com/media/files/yolo9000.weights

#--------------------
# For OpenCV
#FROM jjanzic/docker-python3-opencv

# python 3.6
RUN apt-get update \
    && apt-get install -y software-properties-common curl \
    && add-apt-repository ppa:jonathonf/python-3.6 \
    && apt-get remove -y software-properties-common \
    && apt autoremove -y \
    && apt-get update \
    && apt-get install -y python3.6 \
    && curl -o /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \
    && python3.6 /tmp/get-pip.py \
    && apt-get remove -y curl \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    vim \
    x11-apps \
    build-essential \
    cmake \
    git \
    libgtk2.0-dev \
    wget \
    unzip \
    yasm \
    pkg-config \
    libswscale-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libavformat-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*


RUN pip install numpy

WORKDIR /
ENV OPENCV_VERSION="3.4.0"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..\
&& make \
&& make install \
&& rm /${OPENCV_VERSION}.zip 



#&& cmake -DBUILD_TIFF=ON \
#  -DBUILD_opencv_java=OFF \
#  -DWITH_CUDA=OFF \
#  -DENABLE_AVX=ON \
#  -DWITH_OPENGL=ON \
#  -DWITH_OPENCL=ON \
#  -DWITH_IPP=ON \
#  -DWITH_TBB=ON \
#  -DWITH_EIGEN=ON \
#  -DWITH_V4L=ON \
#  -DBUILD_TESTS=OFF \
#  -DBUILD_PERF_TESTS=OFF \
#  -DCMAKE_BUILD_TYPE=RELEASE \
#  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
#  -DPYTHON_EXECUTABLE=$(which python3.6) \
#  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
#  -DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
#&& make install \
#&& rm /${OPENCV_VERSION}.zip 

#&& rm -r /opencv-${OPENCV_VERSION}
#--------------------

#-----------------
#  OpenCV
#RUN apt-get update && apt-get install -y \
#    build-essential \
#    vim \
#    cmake \
#    git \
#    libgtk2.0-dev \
#    pkg-config \
#    libavcodec-dev \
#    libavformat-dev \
#    libswscale-dev \
#    && rm -rf /var/lib/apt/lists/*

#RUN cd /root; git clone https://github.com/opencv/opencv; cd /root/opencv; mkdir build; cd build; cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..; make; make install
#-----------------

