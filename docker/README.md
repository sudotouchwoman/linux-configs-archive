# **Configuring GPU access for Docker containers**

```bash
# make sure docker daemon is up and running
sysctl status docker
sysctl start docker
# in order to run docker commands without sudo
groups
```

In order to run docker commands without `sudo`, add your user
to the `docker` group:

```bash
groups $USER
# create group if it does not exist yet
sudo groupadd docker
sudo usermod -aG docker $USER
```

If docker-compose is not installed for some reason,
one can download the binary directly from the repo 
(here `v2.15.1` is used, but you can replace it with a desired release):

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# make it executable
chmod +x /usr/local/bin/docker-compose
```

In order to use nvidia runtime for docker containers, nvidia container toolkit is required.
For `CentOS 7`, it can be installed with the following commands:

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.repo | sudo tee /etc/yum.repos.d/nvidia-container-tool$
# if toolkit package is listed 
yum search nvidia-container-toolkit
# invalidate yum repo cache
sudo yum clean expire-cache
sudo yum install -y nvidia-container-toolkit
# updates (or creates) /etc/docker/daemon.json and configures
# access to nvidia gpus
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
# in order to test the installation, try running nvidia-smi inside the container
docker run -it --gpus all --runtime nvidia nvidia/cuda:11.4.0-base-ubuntu20.04 nvidia-smi
```

In order to run Jupyter notebook in a container with GPU access, one can use ![these images]() like this:

```yaml
version: v3

services:
  test-smi:
    image: cschranz/gpu-jupyter:v1.4_cuda-11.6_ubuntu-20.04_slim
    # export your uid before docker-compose up:
    # export USER_UID=$(id -u)
    # (or just use $UID instead, it seems to be present in every shell)
    # this is required for appropriate
    # volume permissions
    user: "${USER_UID}:0"
    group_add:
      - users
    runtime: nvidia
    ports:
      - 8890:8888 # jupyter port
      - 8008:8008 # tensorboard port
    volumes:
    # here, example volumes are used for storing data,
    # notebooks and model artifacts. Feel free to modify these
      - ./data:/home/jovyan/data:rw
      - ./notebooks:/home/jovyan/notebooks:rw
      - ./artifacts:/home/jovyan/artifacts:rw
    # you can set a fixed token
    environment:
      - JUPYTER_TOKEN=my-secret-token
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              capabilities: [ gpu ]
```

Note that `cschranz/gpu-jupyter` images are quite heavy 
(`v1.4_cuda-11.6_ubuntu-20.04_slim` takes about 13.5 Gb disk space) and can take some time to pull.

In order to achieve port forwarding to the remote in the background, use the following flags:

```bash
ssh -N -f -C -q -L 9000:localhost:8890 yourusername@yourhostname
ssh -N -f -C -q -L 9008:localhost:8008 yourusername@yourhostname
```

Congrats, you can now access Jupyter server at `http://localhost:9000/?token=my-secret-token` 
(replace `my-secret-token` with your own token) and Tensorboard at `http://localhost:9008/`.
