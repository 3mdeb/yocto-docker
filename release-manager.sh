#!/bin/bash

# DOCKER_USER_NAME="macpijan"
# DOCKER_IMAGE_NAME="auto-changelog"

function usage {
    echo -e "Usage:"
    echo -e "$0 CMD"
    echo -e "Available CMDs:"
    echo -e "\tbuild - build docker image"
    echo -e "\tpush - push docker image to hub.docker"
    echo -e "\tbump_major - bump MAJOR version number"
    echo -e "\tbump_minor - bump MINOR version number"
    echo -e "\tbump_patch - bump PATCH version number"
    exit 1
}

function error {
    echo "[ERROR]: $1"
    exit 1
}

function errorCheck {
    ERROR_CODE="$?"
    if [ "$ERROR_CODE" -ne 0  ]; then
        error "$1 ($ERROR_CODE)"
    fi
}

if [ $# -ne 1 ]; then
    usage
fi

function prepareEnv {
    readonly CONTAINER_CONFIG_FILE="container-config"
    [ ! -f $CONTAINER_CONFIG_FILE ] && error "\"$CONTAINER_CONFIG_FILE\" is missing"
    source container-config

    # make sure that env vars from sourced, container-specific file are present
    [ -z $DOCKER_USER_NAME ] && error "DOCKER_USER_NAME env var is empty"
    [ -z $DOCKER_IMAGE_NAME ] && error "DOCKER_USER_NAME env var is empty"

    # get current verion from VERSION file
    readonly VERSION_FILE="VERSION"
    [ ! -f $VERSION_FILE ] && error "There is no \"VERSION_FILE\" file"
    CURRENT_VERSION="$(cat VERSION)"
    [ -z $CURRENT_VERSION ] && error "CURRENT_VERSION is empty"
    echo "Current version: $CURRENT_VERSION"
}

function buildContainer {
    docker build -t $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest .
    errorCheck "Building \"latest\" failed"

    # create version tag
    docker tag $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:$CURRENT_VERSION
    errorCheck "Tagging \"$CURRENT_VERSION\" failed"
}

function pushContainer {
    # check if required env vars from .travis.yml are exported
    [ -z $DOCKERHUB_USER ] && error "DOCKERHUB_USER env var is empty"
    [ -z $DOCKERHUB_PASSWORD ] && error "DOCKERHUB_PASSWORD env var is empty"

    echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USER" --password-stdin
    errorCheck "docker login failed"

    docker push $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest
    errorCheck "Pushing \"latest\" failed"

    docker push $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:$CURRENT_VERSION
    errorCheck "Pushing \"$CURRENT_VERSION\" failed"
}

function bumpVersion {
    local BUMP="$1"

    [ "$BUMP" != "major" -a \
      "$BUMP" != "minor" -a \
      "$BUMP" != "patch" ] && echo "Invalid BUMP" && exit 1

    # ensure we're up to date
    CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    git fetch && git pull origin $CURRENT_BRANCH
    errorCheck "Failed to pull \"$CURRENT_BRANCH\""

    # bump version
    docker run --rm -v "$PWD":/app treeder/bump $BUMP
    errorCheck "Failed to run \"treeder/bump\" container"

    BUMPED_VERSION="$(cat VERSION)"
    echo "Bumped version: $BUMPED_VERSION"

    # tag
    BRANCH="rel_$BUMPED_VERSION"
    git checkout -b $BRANCH
    errorCheck "Failed to create branch: \"$BRANCH\""
    git commit -am "release $BUMPED_VERSION"
    errorCheck "Failed to create commit"
    git tag -a "$BUMPED_VERSION" -m "version $BUMPED_VERSION"
    errorCheck "Failed to create tag: \"$BUMPED_VERSION\""
    git push origin $BRANCH
    errorCheck "Failed to push branch: \"$BRANCH\""
    git push --tags
    errorCheck "Failed to push tags"
}

CMD="$1"

# common for all actions
prepareEnv

case "$CMD" in
    "build")
        buildContainer
        ;;
    "push")
        pushContainer
        ;;
    "bump_major")
        bumpVersion "major"
        ;;
    "bump_minor")
        bumpVersion "minor"
        ;;
    "bump_patch")
        bumpVersion "patch"
        ;;
    *)
        error "Invalid command: \"$CMD\""
        ;;
esac
