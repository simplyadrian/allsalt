# Simple Tags

- [`centos7`, `latest`: (*centos7/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/centos/Dockerfile)
- [`debian_jessie`: (*debian_jessie/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/debian/Dockerfile)

# AllSalt

A Docker image which allows you to run a containerised Salt-Master and Minion server.
Includes:

* `salt-ssh`
* `salt-api`
* `salt-cloud`
* `salt-master`
* `salt-minion`

## Building Containers

### Centos

##### centos master

```bash
make build-centos
```

##### centos minion

```bash
make build-centos-minion
```

### Debian

##### debian master

```bash
make build-debian
```

### Ubuntu

##### ubuntu master

```bash
make build-ubuntu
```

##### ubuntu minion

```bash
make build-ubuntu-minion
```

## Running the Container

You can easily run the container like so:

    docker run -d -v /path/to/salt/states:/srv/salt simplyadrian/allsalt:${tag}

### Data Container

To create a data container you are going to want the thinnest possible docker
image, simply run this docker command, which will download the simplest possible
docker image:

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt
    -v /etc/salt/master.d -v /srv/salt --name salt-master-data busybox true

This will create a stopped container with the name of `salt-master-data` and
will hold our persistant salt master data. Now we just need to run our master
container with the `--volumes-from` command:

    docker run -d --volumes-from salt-master-data simplyadrian/allsalt

### Sharing Local Folders

To share folders on your local system so you can have your own master
configuration, states, pillars etc just alter the `salt-master-data`
command:

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt
    -v /path/to/local:/etc/salt/master.d -v /path/to/local:/srv/salt
    --name salt-master-data busybox true

Now `/path/to/local` can hold your states and master configuration.

## Ports

The following ports are exposed:

 * `4505`
 * `4506`

These ports allow minions to communicate with the Salt Master.

## Running Salt Commands: EXAMPLES

```bash
# Exec into a running container (replace simplyadrian/allsalt with the
actual container id)
$ docker exec -it simplyadrian/allsalt bash
# ping all attached minions
$ root@CONTAINER_ID:~# salt '*' test.ping
# return any grains (facts) set locally.
$ root@CONTAINER_ID:~# salt '*' grains.items
# run any attached salt states found in /srv/salt
$ root@CONTAINER_ID:~# salt '*' state.apply
```
