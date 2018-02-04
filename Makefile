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
	docker build -t simplyadrian/allsalt/centos/master:2017.7.2 centos/master/
		docker push simplyadrian/allsalt/centos/master:2017.7.2

build-centos-minion: ## build and publish a centos image with only a salt minion.
	docker build -t simplyadrian/allsalt/centos/minion:2017.7.2 centos/minion/ &&\
		docker push simplyadrian/allsalt/centos/minion:2017.7.2

build-debian: ## build and publish a debian image with a salt master.
	docker build -t simplyadrian/allsalt/debian/master:2017.7.2 debian/ &&\
		docker push simplyadrian/allsalt/debian/master:2017.7.2

build-ubuntu: ## build and publish a ubuntu image with a salt master.
	docker build -t simplyadrian/allsalt/ubuntu/master:2017.7.2 ubuntu/master-xenial/ &&\
		docker push simplyadrian/allsalt/ubuntu/master:2017.7.2

build-ubuntu-2016: ## build and publish a ubuntu image with a salt master version 2016.11.3.
	docker build -t simplyadrian/allsalt/ubuntu/master:2016.11.3 ubuntu/master-2016.11.3/ &&\
		docker push simplyadrian/allsalt/ubuntu/master:2016.11.3

build-ubuntu-minion: ## build and publish a ubuntu image with a salt minion only.
	docker build -t simplyadrian/allsalt/ubuntu/minion:2017.7.2 ubuntu/minion/ &&\
		docker push simplyadrian/allsalt/ubuntu/minion:2017.7.2

all: build-centos build-centos-minion build-debian build-ubuntu build-ubuntu-2016 build-ubuntu-minion ## build and publish all to Dockerhub.
