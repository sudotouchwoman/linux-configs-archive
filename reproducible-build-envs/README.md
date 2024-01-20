# Build environment

It sucks when your (or someone's else) code fails to build on your machine.
Or, perhaps, you pushed your code and now it fails to build in other person's environment.

In such cases we come to `docker` and pack our build/runtime dependencies into a reproducible
environment. In this section, I put some configurations that find useful.

## Usage

First, you have to build the images (you may push them somewhere to access later, but that
is out of scope for now):

```bash
# in .docker directory
./build.sh
# then, from devcontainer-cpp to run
# an interactive shell in a temporary container
./tools/run.sh
# or, to launch a daemon and later connect via
# IDE, say VSCode:
./tools/up.sh
# and stop:
docker compose -f .docker/docker-compose.yaml down
``` 
