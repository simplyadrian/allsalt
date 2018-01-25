FROM ubuntu:latest
MAINTAINER Intuitive Technology Group <devops@intuitivetech.com>

# Update System and install packages
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::=--force-confdef \
                       -o DPkg::Options::=--force-confold &&\
    apt-get install -qq -y --no-install-recommends --no-install-suggests \
                    apt-transport-https \
                    ca-certificates \
                    curl \
                    git \
                    vim \
                    make &&\
    curl -fsSL  https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub \
    | apt-key add - &&\
    echo "deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main" >> \
    /etc/apt/sources.list.d/saltstack.list &&\
    apt-get update &&\
    apt-get install -y -qq -y --no-install-recommends --no-install-suggests salt-minion  &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Add Run File
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Run Command
CMD "/usr/local/bin/run.sh"
