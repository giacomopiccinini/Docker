# Pull image of tensorflow
FROM ubuntu:20.04

# Disable interaction
ENV DEBIAN_FRONTEND=noninteractive 

# Ensure bash is the shell
CMD [ "bash" ]

# Install pip
RUN apt-get update 
RUN apt-get install -y python3-pip

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

# Copy app into home directory
COPY app/ /home/app/




