FROM opensuse:latest
MAINTAINER Adrian Herrera <adrian.herrera@intuitivetech.com>

# Update System and install packages
RUN zypper update -y &&\
    zypper install -y \
            ca-certificates \
            curl \
            git \
            make \
            python \
            python-devel \
            python-pip \
            python-setuptools &&\
    zypper addrepo http://repo.saltstack.com/opensuse/SLE_12_SP2/systemsmanagement:saltstack:products.repo &&\
    zypper --gpg-auto-import-keys refresh -f &&\
    zypper install -y \
            salt-master \
            salt-minion \
            salt-cloud \
            salt-ssh \
            salt-api &&\
    zypper clean

# Add Run File
ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports
EXPOSE 4505 4506

# Run Command
CMD "/usr/local/bin/run.sh"
