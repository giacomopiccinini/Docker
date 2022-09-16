#!/bin/bash

# AFTER image is created, run container from it. In particular:
# - Mount volume named "Input"
# - Mount volume named "Output"
# - Name the container my_container
# - Run in detached mode (-d)
# - Make it interactive (-it)
docker container run \
   --volume "/$(pwd)/Input":/home/app/Input \
   --volume "/$(pwd)/Output":/home/app/Output \
   --name my_container \
   -dit ubuntu

# Run reconstruction
docker container exec my_container python3 main.py

# Remove container
docker container rm -f my_container

