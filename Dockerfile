FROM ubuntu:16.04
MAINTAINER Adrian Herrera <simplyadrian@gmail.com>

# Update System and install packages
RUN apt-get update && \
    apt-get upgrade -y -o DPkg::Options::=--force-confold &&\
    apt-get install -qq -y --no-install-recommends --no-install-suggests \
                    wget &&\
	wget --no-check-certificate -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - &&\
	echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" >> \
	/etc/apt/sources.list.d/saltstack.list &&\
	apt-get update &&\
	apt-get install -y \
    salt-master \
	salt-minion \
    salt-cloud \
    salt-ssh \
    salt-api &&\
	apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Volumes
VOLUME ["/etc/salt/pki", "/var/cache/salt", "/var/logs/salt", "/etc/salt/master.d", "/srv/salt"]

# Add Run File
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports
EXPOSE 4505 4506

# Run Command
CMD "/usr/local/bin/run.sh"
