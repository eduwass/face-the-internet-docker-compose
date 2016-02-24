#!/usr/bin/env bash
eval $(docker-machine env facethemachine)
docker-machine start facethemachine
docker-compose run server bash