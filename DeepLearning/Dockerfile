# Pull image of Tensorflow2 with Python 3.8.10
FROM nvcr.io/nvidia/tensorflow:22.07-tf2-py3

# Ensure bash is the shell
CMD [ "bash" ]

# Upgrade pip
RUN pip install --upgrade pip 

# Copy app into home directory
COPY app/ /home/app

# Set /home/app as the directory you are re-directed to
WORKDIR /home/app

# Install python requirements
RUN pip install -r requirements.txt

# Ensure openCV dependencies are installed correctly
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

# Reduce tensorflow logs
RUN export TF_CPP_MIN_LOG_LEVEL=1

