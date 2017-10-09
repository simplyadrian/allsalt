FROM centos:centos7

MAINTAINER Adrian Herrera <adrian.herrera@intuitivetech.com>

ENV salt_version 2017.7.2-1.el7.noarch

# Add salt repositories and install dependencies
RUN yum -y update && \
    yum install -y \
                https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm \
                gcc \
                libffi-devel \
                python \
                python-devel \
                bzip2-devel \
                git \
                openssl \
                openssl-devel \
                make \
                zlib-devel \
                tar &&\
	yum clean expire-cache

# Install setuptools + pip
RUN cd /tmp && \
    curl https://bootstrap.pypa.io/get-pip.py -O &&\
    python2.7 get-pip.py

RUN yum install -y \
	            salt-master-${salt_version} \
	            salt-minion-${salt_version} \
	            salt-ssh-${salt_version} \
	            salt-cloud-${salt_version} \
	            salt-api-${salt_version}

# Install ansible and its dependencies
RUN pip install pyaml setuptools boto3 boto virtualenv credstash &&\
    yum clean all && rm -rf /tmp/* /var/tmp/*

# Volumes
VOLUME ["/etc/salt/pki", "/var/logs/salt", "/srv/salt"]

# Add Run File
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports
EXPOSE 4505 4506

# Run Command
CMD "/usr/local/bin/run.sh"
