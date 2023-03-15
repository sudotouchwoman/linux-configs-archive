# **SSH Cheatsheet**


```bash
# Convert private key to RSA format
ssh-keygen -p -m PEM -f keyname.pem

# Connect to the host using a particular private key
ssh -i ~/.ssh/key user@hostname

# Add host to the list of `known_hosts`:
ssh-keyscan -t rsa $HOSTNAME >> ~/.ssh/known_hosts

# Forward local port 9008 to a remote port 8008
ssh -N -f -C -q -L 9008:localhost:8008 user@hostname

# Search ssh-related processes (with names)
pgrep ssh -l
# (or other processes)
pgrep code -l

# Convenient way to close all ssh connections
kill $(pidof ssh)
```

Gitlab job template to log in to remote host. Make sure that `SSH_PRIVATE_KEY` variable exists and is of
file type. It should contain a `base64`-encoded private key. One can produce it like this:

```bash
base64 -w0 < ~/.ssh/key > key64.pem
```

Make sure that the job has access to the variable (i.e., it is either a protected branch or the variable itself
is unprotected), otherwise the job would fail.

```yaml
.ssh-login:
  before_script:
    # assuming that we're running on alpine
    # which has no apt-get, have to use apk instead
    - which ssh-agent || ( apk add --update --no-cache openssh )
    - eval $(ssh-agent -s)
    - mkdir -p ~/.ssh
    - cat "${SSH_PRIVATE_KEY}" | base64 -d | tr -d '\r' | ssh-add -
    - chmod 600 ~/.ssh/
    - ssh-keyscan -t rsa $SSH_HOST >> ~/.ssh/known_hosts
    - ssh $SSH_USER@$SSH_HOST "echo 'logged in'"
```

If for some reason you would want to embed auth credentials into a container:

```Dockerfile
FROM alpine:latest

# COPY rsa64.pem /opt/rsa64.pem
RUN apk add --update --no-cache openssh \
    && eval $(ssh-agent -s) \
    && mkdir ~/.ssh \
    && echo "your-base64-encoded-private-key" | base64 -d > ~/.ssh/id_rsa \
    && chmod 400 ~/.ssh/* \
    && ssh-keyscan -t rsa $HOSTNAME >> ~/.ssh/known_hosts

ENTRYPOINT [ "ssh", "ubuntu@$HOSTNAME" ]
```

