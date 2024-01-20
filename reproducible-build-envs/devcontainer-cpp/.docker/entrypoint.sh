#!/bin/env bash

# Add local user
# Either use the USER_UID if passed in at runtime or
# fallback to the default values

USER_NAME=${USER_NAME:-dev}
USER_GROUP=${USER_GROUP:-$USER_NAME}
USER_PASSWD=${USER_PASSWD:-devel}
USER_UID=${USER_UID:-9000}
USER_GID=${USER_GID:-$USER_UID}

groupadd -g $USER_GID $USER_GROUP && useradd -m --shell /bin/bash -r -g $USER_GROUP -o -u $USER_UID -G sudo $USER_NAME && echo "$USER_NAME:$USER_PASSWD" | chpasswd;
export HOME=/home/$USER_NAME && cd $HOME
[[ -d /opt/.ssh ]] && ln -s /opt/.ssh ~/.ssh
[[ -d /opt/project ]] && ln -s /opt/project ~/project

# checkout to the new user
# note that with docker exec calls
# you will end up in the root shell
# (since your user is created at container runtime)
exec /usr/local/bin/gosu $USER_NAME "$@"
