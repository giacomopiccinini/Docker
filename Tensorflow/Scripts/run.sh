#!/bin/bash

# AFTER image is created, run container from it. In particular:
# - Ensure all GPU are visible
# - Specify a few standard options to make TF run smoothly
# - Mount volume named "Input"
# - Mount volume named "Output"
# - Name the container my_container
# - Run in detached mode (-d)
# - Make it interactive (-it)

docker container run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 --volume "/$(pwd)/Input":/home/app/Input --volume "/$(pwd)/Output":/home/app/Output --name my_container -dit my_image