build-centos:
	docker build -t simplyadrian/allsalt:centos7 centos/
build-debian:
	docker build -t simplyadrian/allsalt:debian_jessie debian/
build-ubuntu:
	docker build -t simplyadrian/allsalt:ubuntu_xenial ubuntu/
