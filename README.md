[![Build Status](https://travis-ci.org/intuitivetechnologygroup/allsalt.svg?branch=master)](https://travis-ci.org/intuitivetechnologygroup/allsalt)

# AllSalt

A Docker image which allows you to run a containerised `salt-master/minion` server.
Includes:

* `salt-ssh`
* `salt-api`
* `salt-cloud`
* `salt-master`
* `salt-minion`

---

* [Simple Tags](#simple-tags)
* [Building Containers](#building-containers)
* [Running a Container](#running-container)
* [Ports](#ports)
* [Examples](#examples)

---

## <a name="simple-tags"></a> Simple Tags

- [`centos_master_2017.7.2`: (*centos_master_2017.7.2/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/centos/master/Dockerfile)
- [`centos_minion_2017.7.2`: (*centos_minion_2017.7.2/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/centos/minion/Dockerfile)
- [`debian_master_2017.7.2`: (*debian_master_2017.7.2/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/debian/Dockerfile)
- [`opensuse_master_2017.7.2`: (*opensuse_master_2017.7.2/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/opensuse/Dockerfile)
- [`ubuntu_master_2017.7.2`: (*ubuntu_master_2017.7.2/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/ubuntu/master-xenial/Dockerfile)
- [`ubuntu_master_2016.11.3`: (*ubuntu_master_2016.11.3/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/ubuntu/master-2016.11.3/Dockerfile)
- [`ubuntu_minion_2017.7.2`: (*ubuntu_minion_2017.7.2/Dockerfile*)](https://github.com/simplyadrian/allsalt/blob/master/ubuntu/minion/Dockerfile)


## <a name="building-containers"></a> Building Containers

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

### OpenSuse

##### opensuse master

```bash
make build-opensuse
```

### Ubuntu

##### ubuntu master

```bash
make build-ubuntu
```

##### ubuntu master 2016

```bash
make build-ubuntu-2016
```

##### ubuntu minion

```bash
make build-ubuntu-minion
```

### ALL

```bash
make all
```

## <a name="running-container"></a> Running a Container

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


## <a name="ports"></a> Ports

The following ports are exposed:

 * `4505`
 * `4506`

These ports allow minions to communicate with the Salt Master.


## <a name="examples"></a> Examples

### Running Salt Commands

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


### Master/Minion Test Environment Example

#### setup the file system

```bash
mkdir -p master/{master.d,srv}
mkdir -p minion/minion.d
```

#### start master container:

```bash
docker run --rm -d \
    -v $(pwd)/master/master.d:/etc/salt/master.d \
    -v $(pwd)/master/srv:/srv \
    -h dev-salt-master \
    --name dev-salt-master \
    simplyadrian/allsalt:debian_jessie
```

##### start minion container:

```bash
docker run --rm -d \
    -v $(pwd)/minion/minion.d:/etc/salt/minion.d \
    -h dev-ubuntu-minion \
    --name dev-ubuntu-minion \
    simplyadrian/allsalt/minion:ubuntu_latest
```

#### Accept the keys:

```bash
docker exec -it dev-salt-master bash
salt-key
salt-key -A -y
salt \* test.ping
```
