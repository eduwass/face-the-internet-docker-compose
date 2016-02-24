#!/usr/bin/env bash

#########################################################################
# Set env vars
##########################################################################

# Figure out WordPress location ( has to full path! )
THIS_DIR=$(pwd) 
WORDPRESS_DIR=$THIS_DIR/php\-fpm/wordpress

# Set WORDPRESS_DIR as env variable in order to be picked up by docker-compose.yml
export WORDPRESS_DIR=$WORDPRESS_DIR