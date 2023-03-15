# **Shell hacks**

Parse docker credentials config with `jq`:

```bash
cat ~/.docker/config.json | jq -r '.auths["registry.gitlab.com"] | to_entries[] | .value'
```

Store docker credentials in separate configs to the same registry (e.g., `gitlab.registry.com`). I found it 
useful as gitlab provides a single registry domain while permissions for different projects may vary. Related [SO question](https://stackoverflow.com/questions/50177884/how-to-use-multiple-auths-logins-for-same-docker-registry).

```bash
docker --config ~/.different pull myregistry/myimage
```

One can use local docker client installation in order to manage applications
on a remote host. In the simplest scenario, set an environmental variable `DOCKER_HOST` to
a remote host and user like this:

```bash
export DOCKER_HOST="ssh://username@hostname"
```

Now docker client will connect to docker socket at provided remote host. As far as
I cana say, this setup uses credentials from the local machine, which is rather sane given
that authentication is performed on docker client side.
