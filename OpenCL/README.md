# Docker Implementation of a generic Deep Learning framework

## Introduction

For Deep Learning applications, the explotation of GPUs is essential. However, with Docker, one can't use the GPU of the host machine straight away (for e.g. TensorFlow). The reason is that most DockerHub images do *not* come with CUDA (and similar) support, thus making the GPU "invisible". 

For this reason, I suggest the use of Nvidia official images that natively take care of the issue. For instance, in this example I will pull their image for a TensorFlow2 environment. The obvious downside is that such images are pretty heavy, and require a certain amount of disk space when compared to some vanilla python image (roughly 12 GB vs 3 GB). 

*Note: I could not find Nvidia images on DockerHub. I recommend to check out [their website](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html), for docs and specs.*

## Preliminaries

Even with Nvidia images, GPUs may not be immediately visible to our TensorFlow application. Some extra-work is needed. First of all, it could be that you can't use the `nvidia-smi` command on your machine (irrespective of Docker). This is usually due to some mismatch in driver versions of the GPU hardware. What solved the issue for me was the two-step procedure:

1. `sudo apt-get --purge remove "*nvidia*"`

2. `sudo /usr/bin/nvidia-uninstall`

At this point, you should be able to successfully use the `nvidia-smi` command and get back something meaningful. This will be useful later on, when double-checking that Docker recognises GPUs. If this didn't work, please consult this [StackOverflow question](https://stackoverflow.com/questions/43022843/nvidia-nvml-driver-library-version-mismatch#comment73133147_43022843). After that, we need to fix the interplay between Docker and Nvidia. On Ubuntu 18.04 (AWS EC2 instance), what worked for me were the following steps (from [this question](https://stackoverflow.com/questions/59008295/add-nvidia-runtime-to-docker-runtimes)):

1. Download the Nvidia container runtime:

`sudo apt-get install nvidia-container-runtime`

2. Run:

`sudo tee /etc/docker/daemon.json <<EOF
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF`

3. Run:

`sudo pkill -SIGHUP dockerd`

4. Run:

`for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done`

5. As a cross-check, run:

`docker info|grep -i runtime`

You should get back something like
```
 Runtimes: nvidia runc
 Default Runtime: runc
```

After completing this procedure, and after having built the image and created the container, you could open up the bash prompt of the container (see below) and check that `nvidia-smi` gives back something meaningful. 

## OpenCL

Even after following the above instructions, OpenCL is not visible in the Docker container. That is because we have not really installed it. Hence, on top of the NVIDIA image, we should install a few other things, detailed in the `Dockerfile`. OpenCL is handy when using GPUs and, in particular, it is essential for running *pyclesperanto*. 

## Docker setup

To use Docker, first proceed at creating the image. It is important that weights for the trained model are stored in `app/Models/` *before* building the image. This way, they will be automatically copied inside the image. An alternative is to mount a volume with them. You choose what suits you best. The actual building can be done by executing the script:

`sh Scripts/build.sh`

All necessary python packages are installed, the code copied in `/home/app` from the local `app/` directory. It is just the standard way of creating an image starting from the Dockerfile. 

Now it is time to create and run a container. Before doing so, please ensure that you have your input data copied in the `Input/` directory on your local machine: when running `sh Scripts/run.sh`, the directories `Input/` and `Output/` will be mounted in `/home/app` of the container: this means that *local* `Input/Output` directories are synchronised with *container* `Input/Output`: what happens on the one side also happens on the other! So, simply execute:

`sh Scripts/run.sh`

## Running the app

Now that our container is up and running we can start playing with it. If we simply want to connect to its shell we could run 

`docker exec -it my_container bash`

This will open up the bash prompt, and we can start using Ubuntu's CLI commands. Remember to type `exit` to close it. In order to run (python) scripts in a container, we need not have its shell open (even though we could do that). It is sufficient to call, from our local machine:

`docker exect -it my_container python my_script.py`

assuming, of course, `my_script.py` is stored in `/home/app` inside the container. As a simple HelloWorld application we could run

`sh Scripts/exec.sh -p <YourName>`

## Deleting the container

Once we are done with the container, it is better to remove it from the local machine. We could either stop it first and then remove it, or forcefully delete it. To do so:

`sh Scripts/remove.sh`


 



