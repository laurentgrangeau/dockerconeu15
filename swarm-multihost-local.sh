#!/bin/bash

set -e

docker-machine create -d virtualbox kvstore-swarm
docker $(docker-machine config kvstore-swarm) run -d -p "8500:8500" -h "consul" progrium/consul -server -bootstrap

docker-machine create -d virtualbox --swarm --swarm-master --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1:2376" swarm-master

docker-machine create -d virtualbox --swarm --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1:2376" --engine-label="environment=frontend" swarm-slave1
docker-machine create -d virtualbox --swarm --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1:2376" --engine-label="environment=middleend" swarm-slave2
docker-machine create -d virtualbox --swarm --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1:2376" --engine-label="environment=backend" swarm-slave3

docker $(docker-machine config swarm-slave1) run -d --name=registrator --net=host --volume=//var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -internal consul://$(docker-machine ip kvstore-swarm):8500
docker $(docker-machine config swarm-slave2) run -d --name=registrator --net=host --volume=//var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -internal consul://$(docker-machine ip kvstore-swarm):8500
docker $(docker-machine config swarm-slave3) run -d --name=registrator --net=host --volume=//var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -internal consul://$(docker-machine ip kvstore-swarm):8500 
