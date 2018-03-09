# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container
build-centos: ## build and publish a centos image with salt master.
	docker build -t simplyadrian/allsalt:centos_master_2017.7.2 centos/master/
	@echo 'publish centos_master_2017.7.2 to simplyadrian/allsalt with Dockerhub autobuild'

build-centos-minion: ## build and publish a centos image with only a salt minion.
	docker build -t simplyadrian/allsalt:centos_minion_2017.7.2 centos/minion/
	@echo 'publish centos_minion_2017.7.2 to simplyadrian/allsalt with Dockerhub autobuild'

build-debian: ## build and publish a debian image with a salt master.
	docker build -t simplyadrian/allsalt:debian_master_2017.7.2 debian/
	@echo 'publish debian_master_2017.7.2 to simplyadrian/allsalt with Dockerhub autobuild'

build-opensuse: ## build and publish a opensuse image with a salt master.
	docker build -t simplyadrian/allsalt:opensuse_master_2017.7.2 opensuse/
	@echo 'publish opensuse_master_2017.7.2 to simplyadrian/allsalt with Dockerhub autobuild'

build-ubuntu: ## build and publish a ubuntu image with a salt master.
	docker build -t simplyadrian/allsalt:ubuntu_master_2017.7.2 ubuntu/master-xenial/
	@echo 'publish ubuntu_master_2017.7.2 to simplyadrian/allsalt with Dockerhub autobuild'

build-ubuntu-2016: ## build and publish a ubuntu image with a salt master version 2016.11.3.
	docker build -t simplyadrian/allsalt:ubuntu_master_2016.11.3 ubuntu/master-2016.11.3/
	@echo 'publish ubuntu_master_2016.11.3 to simplyadrian/allsalt with Dockerhub autobuild'

build-ubuntu-minion: ## build and publish a ubuntu image with a salt minion only.
	docker build -t simplyadrian/allsalt:ubuntu_minion_2017.7.2 ubuntu/minion/
	@echo 'publish ubuntu_minion_2017.7.2 to simplyadrian/allsalt with Dockerhub autobuild'

test-build-centos: build-centos
	docker rmi simplyadrian/allsalt:centos_master_2017.7.2

test-build-centos-minion: build-centos-minion
	docker rmi simplyadrian/allsalt:centos_minion_2017.7.2

test-build-debian: build-debian
	docker rmi simplyadrian/allsalt:debian_master_2017.7.2

test-build-opensuse: build-opensuse
	docker rmi simplyadrian/allsalt:opensuse_master_2017.7.2

test-build-ubuntu: build-ubuntu
	docker rmi simplyadrian/allsalt:ubuntu_master_2017.7.2

test-build-ubuntu-2016: build-ubuntu-2016
	docker rmi simplyadrian/allsalt:ubuntu_master_2016.11.3

test-build-ubuntu-minion: build-ubuntu-minion
	docker rmi simplyadrian/allsalt:ubuntu_minion_2017.7.2

all: build-centos build-centos-minion build-debian build-ubuntu build-ubuntu-2016 build-ubuntu-minion build-opensuse ## build and publish all to Dockerhub with autobuild.
