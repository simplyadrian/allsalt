# Docker AllSalt

A Docker image which allows you to run a containerised Salt-Master and Minion server.
Includes:
 * salt-ssh
 * salt-api
 * salt-cloud
 * salt-master
 * salt-minion

## Running the Container

You can easily run the container like so:

    docker run -d -v /path/to/salt/states:/srv/salt simplyadrian/allsalt

## Volumes

There are several volumes which can be mounted to Docker data container as
described here: https://docs.docker.com/userguide/dockervolumes/. The following
volumes can be mounted:

 * `/etc/salt/pki` - This holds the Salt Minion authentication keys
 * `/var/cache/salt` - Job and Minion data cache
 * `/var/logs/salt` - Salts log directory
 * `/etc/salt/master.d` - Master configuration include directory
 * `/srv/salt` - Holds your states, pillars etc

### Data Container

To create a data container you are going to want the thinnest possible docker
image, simply run this docker command, which will download the simplest possible
docker image:

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /etc/salt/master.d -v /srv/salt --name salt-master-data busybox true

This will create a stopped container wwith the name of `salt-master-data` and
will hold our persistant salt master data. Now we just need to run our master
container with the `--volumes-from` command:

    docker run -d --volumes-from salt-master-data simplyadrian/allsalt

### Sharing Local Folders

To share folders on your local system so you can have your own master
configuration, states, pillars etc just alter the `salt-master-data`
command:

    docker run -v /etc/salt/pki -v /var/salt/cache -v /var/logs/salt -v /path/to/local:/etc/salt/master.d -v /path/to/local:/srv/salt --name salt-master-data busybox true

Now `/path/to/local` can hold your states and master configuration.

## Ports

The following ports are exposed:

 * `4505`
 * `4506`

These ports allow minions to communicate with the Salt Master.

## Running Salt Commands

    # Exec into a running container (replace simplyadrian/allsalt with the
    actual container id)
    $ docker exec -it simplyadrian/allsalt bash
    # ping all attached minions
    $ root@CONTAINER_ID:~# salt '*' test.ping
    # return any grains (facts) set locally.
    $ root@CONTAINER_ID:~# salt '*' grains.items
    # run any attached salt states found in /srv/salt
    $ root@CONTAINER_ID:~# salt '*' state.apply
