# **Create custom sytemd services**

## Create a gitlab runner installation inside a container:

```properties
[Unit]
Description=Gitlab Runner Service
After=network-online.target docker.target
Wants=network-online.target docker.target

[Service]
TimeoutStartSec=30s
RestartSec=10s

Type=simple
Restart=on-failure

WorkingDirectory=/home/dev/projects/gitlab-runner
ExecStartPre=/usr/local/bin/docker-compose -f docker-compose.yaml down
ExecStart=/usr/local/bin/docker-compose -f docker-compose.yaml up
ExecStop=/usr/local/bin/docker-compose -f docker-compose.yaml stop

[Install]
WantedBy=default.target
```

One should supply valid paths to executables (like `docker-compose`) and manifest files.
In this case, the conents of `docker-compose.yaml` file are:

```yaml
version: v3

services:
  runner:
    image: gitlab/gitlab-runner:alpine3.15
    volumes:
      - gitlab-runner-config:/etc/gitlab-runner
      - /var/run/docker.sock:/var/run/docker.sock

volumes:
  gitlab-runner-config:
```

## Activation

This unit file can be activated using the following commands
(assuming that the file is located at `~/.config/systemd/user` directory):

```properties
systemctl --user enable gitlab.service
systemctl --user start gitlab.service
```

## Useful resources:

+ https://hub.docker.com/r/gitlab/gitlab-runner
+ https://docs.gitlab.com/runner/register/index.html#docker
+ https://www.baeldung.com/linux/run-script-on-startup
+ https://unix.stackexchange.com/questions/365544/error-creating-systemd-service-for-dockered-service
+ https://unix.stackexchange.com/questions/506347/why-do-most-systemd-examples-contain-wantedby-multi-user-target
+ https://stackoverflow.com/questions/54767751/running-a-docker-container-with-systemd
