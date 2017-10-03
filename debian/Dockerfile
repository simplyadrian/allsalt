FROM debian:jessie
MAINTAINER Adrian Herrera <simplyadrian@gmail.com>

ENV docker_version 17.06.0
ENV salt_version 2017.7.1
ADD ./git-lfs_1.4.4_amd64.deb /git-lfs_1.4.4_amd64.deb

# Update System and install packages
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::=--force-confdef \
                       -o DPkg::Options::=--force-confold &&\
    apt-get install -qq -y --no-install-recommends --no-install-suggests \
                    apt-transport-https=1.0.9.8.4 \
                    ca-certificates=20141019+deb8u3 \
                    curl=7.38.0-4+deb8u5 \
                    git=1:2.1.4-2.1+deb8u5 \
                    make=4.0-8.1 &&\
    curl -fsSL  https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub \
    | apt-key add - &&\
    echo "deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main" >> \
    /etc/apt/sources.list.d/saltstack.list &&\
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&\
    echo "deb https://download.docker.com/linux/debian jessie stable" >> \
    /etc/apt/sources.list.d/docker.list &&\
    apt-get update &&\
    dpkg -i /git-lfs_1.4.4_amd64.deb &&\
    apt-get install -f -qq -y --no-install-recommends --no-install-suggests &&\
    apt-get install -y -qq -y --no-install-recommends --no-install-suggests \
                    salt-master=${salt_version}+ds-1 \
                    salt-minion=${salt_version}+ds-1 \
                    salt-cloud=${salt_version}+ds-1 \
                    salt-ssh=${salt_version}+ds-1 \
                    salt-api=${salt_version}+ds-1 \
                    docker-ce=${docker_version}~ce-0~debian &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Volumes
VOLUME ["/etc/salt/pki", "/var/cache/salt", "/var/logs/salt", \
        "/etc/salt/master.d", "/srv/salt"]

# Add Run File
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports
EXPOSE 4505 4506

# Run Command
CMD "/usr/local/bin/run.sh"
