# Pull image of tensorflow
FROM nvcr.io/nvidia/tensorflow:22.07-tf2-py3

# Update and upgrade
RUN apt-get update
RUN apt-get -y upgrade

# Install open-CL
RUN apt-get -y install ocl-icd-libopencl1
RUN apt-get -y install opencl-headers
RUN apt-get -y install clinfo

# Ensure bash is the shell
CMD [ "bash" ]

# Upgrade pip
RUN pip install --upgrade pip 

# Copy app into home directory
COPY app/requirements.txt /home/app/requirements.txt

# Move to app directory
WORKDIR /home/app

# Install requirements
RUN pip install -r requirements.txt

# Ensure openCV dependencies are installed correctly
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

# Reduce tensorflow logs
RUN export TF_CPP_MIN_LOG_LEVEL=1

# Copy app into home directory
COPY app/ /home/app/

# Ensure openCL can be used
RUN mkdir -p /etc/OpenCL/vendors 
RUN echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd





