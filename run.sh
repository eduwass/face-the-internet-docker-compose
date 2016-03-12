#!/usr/bin/env bash

#########################################################################
# Config vars
#########################################################################
# Port
PORT=80

# Set to the name of the Docker machine you want to use
DOCKER_MACHINE_NAME=facethemachine

# Set to the name of the Docker image you want to use
DOCKER_IMAGE_NAME=facetheimage

# Hostname (URL)
HOSTNAME=monzadocker

# Set env vars
# source set_env.sh
# printenv WORDPRESS_DIR

#########################################################################
# Create Docker machine and set up env (if neccesary)
#########################################################################

echo "-----------------------------------------------------------"
echo "List of existing Docker machines"
echo "-----------------------------------------------------------"
docker-machine ls
echo "-----------------------------------------------------------"

# Machine exists and is Running
if (docker-machine ls | grep "^$DOCKER_MACHINE_NAME .* Running"); then
  echo "-----------------------------------------------------------"
  echo "Machine exists and is already running"
  echo "Moving over to next step ..."
  echo "-----------------------------------------------------------"
else

  # Machine doesnt exist
  if !(docker-machine ls | grep "^$DOCKER_MACHINE_NAME "); then
    echo "-----------------------------------------------------------"
    echo "Creating Docker machine: $DOCKER_MACHINE_NAME"
    echo "-----------------------------------------------------------"
    docker-machine create --driver=virtualbox --virtualbox-memory=512 --virtualbox-cpu-count=1 $DOCKER_MACHINE_NAME
  fi

  # Machine exists but Stopped
  if (docker-machine ls | grep "^$DOCKER_MACHINE_NAME .* Stopped"); then
    echo "-----------------------------------------------------------"
    echo "Starting Docker machine ... $DOCKER_MACHINE_NAME"
    echo "-----------------------------------------------------------"
    docker-machine start $DOCKER_MACHINE_NAME
  fi

  #########################################################################
  # Build images:
  #########################################################################
  echo "-----------------------------------------------------------"
  echo "Building images"
  echo "-----------------------------------------------------------"
  eval $(docker-machine env $DOCKER_MACHINE_NAME)
  docker-compose build

fi

# Load your Docker host's environment variables
echo "-----------------------------------------------------------"
echo "Loading Docker env variables"
eval $(docker-machine env $DOCKER_MACHINE_NAME)
echo "-----------------------------------------------------------"

#########################################################################
# Add host to /etc/hosts
#########################################################################
# echo "-----------------------------------------------------------"
# echo "Adding host $HOSTNAME"
# echo "-----------------------------------------------------------"
# echo "$(docker-machine ip $DOCKER_MACHINE_NAME) $HOSTNAME" | sudo tee -a /etc/hosts


#########################################################################
# Output info
#########################################################################
echo "-----------------------------------------------------------"
echo "Machine info"
echo "-----------------------------------------------------------"
INTERNAL_IP=$(docker-machine ip $DOCKER_MACHINE_NAME) 
echo "To access Client open this address with web browser:"
echo $INTERNAL_IP:3000
open http://$INTERNAL_IP:3000

#########################################################################
# Bring up environment:
#########################################################################
echo "-----------------------------------------------------------"
echo "docker-compose-up"
echo "-----------------------------------------------------------"
docker-compose up


# #########################################################################
# # Next browse to http://$HOSTNAME
# #########################################################################
# open http://$HOSTNAME

