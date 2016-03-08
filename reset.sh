#!/usr/bin/env bash

#########################################################################
# Reset Docker stuff
##########################################################################
echo "# Resetting Docker to default state"

echo "##### 1. Stop and remove Docker containers:"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

echo "##### 2. Kill and remove Docker containers (just in case):"
docker rm $(docker kill $(docker ps -aq))

echo "##### 3. Remove all images"
docker rmi $(docker images -q)

echo "##### 4. Stop and remove docker-machine"
docker-machine stop dev
docker-machine rm dev