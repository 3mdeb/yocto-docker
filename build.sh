#!/bin/bash

USERNAME="3mdeb"
IMAGE="yocto-docker"

docker build -t $USERNAME/$IMAGE:latest .
