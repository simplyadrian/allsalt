FROM centos:centos7

MAINTAINER Adrian Herrera <adrian.herrera@intuitivetech.com>

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

RUN yum install -y salt-minion.noarch &&\
    yum clean all && rm -rf /tmp/* /var/tmp/*

# Add Run File
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Run Command
CMD "/usr/local/bin/run.sh"
