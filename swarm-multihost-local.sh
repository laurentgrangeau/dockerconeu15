#!/bin/bash

set -e

docker-machine create -d virtualbox kvstore-swarm
docker $(docker-machine config kvstore-swarm) run -d -p "8500:8500" -h "consul" progrium/consul -server -bootstrap

docker-machine create -d virtualbox --swarm --swarm-master --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1" swarm-master

docker-machine create -d virtualbox --swarm --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1" swarm-slave1
docker-machine create -d virtualbox --swarm --swarm-discovery consul://$(docker-machine ip kvstore-swarm):8500 --engine-opt="cluster-store=consul://$(docker-machine ip kvstore-swarm):8500" --engine-opt="cluster-advertise=eth1" swarm-slave2
