# Docker Image for Python Using Ubuntu 20.04

## Introduction 

For some tasks, GPUs are not be used, hence it makes more sense to use a lightweight image, compared to e.g. Nvidia images. I chose Ubuntu 20.04, which seems a good deal. Python is already installed, but installation of pip is required. Notice that, for this type of image, when launching Python scripts one needs to use `python3` as opposed to the more standard `python`. 

## Docker setup

To use Docker, first proceed at creating the image. The actual building can be done by executing the script:

`sh Scripts/setup.sh`

The building should take a few minutes. All necessary python packages are installed, the code copied in `home/app` from the local `app/` directory. 

## Running

After completing the steps above, run the `main.py` script with:

`sh Scripts/run.sh`

This script will:

- Create a container; 
- Mount `Input/` and `Output/` volumes, so that input data will be shared with the container and, similarly, 
output data will be shared with the local machine; 
- Run the script inside that container; 
- Remove the container after the reconstruction is over.  



