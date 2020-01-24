#!/bin/bash

source container-config

docker build -t $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest .
