build-centos:
	docker build -t simplyadrian/allsalt:centos7 centos/master/
build-centos-minion:
	docker build -t simplyadrian/allsalt/minion:centos7 centos/minion/

build-debian:
	docker build -t simplyadrian/allsalt:debian_jessie debian/

build-ubuntu:
	docker build -t simplyadrian/allsalt:ubuntu_xenial ubuntu/master-xenial/
build-ubuntu-minion:
	docker build -t simplyadrian/allsalt/minion:ubuntu_latest ubuntu/minion/
