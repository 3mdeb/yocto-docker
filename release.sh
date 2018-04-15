#!/bin/bash

USERNAME="3mdeb"
IMAGE="yocto-docker"

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "$0 BUMP"
    echo "Available BUMPs: major, minor, patch, pre"
    exit 1
fi

BUMP="$1"

[ "$BUMP" != "major" -a \
  "$BUMP" != "minor" -a \
  "$BUMP" != "patch" -a \
  "$BUMP" != "pre" ] && echo "Invalid BUMP" && exit 1

# ensure we're up to date
git pull

# bump version
docker run --rm -v "$PWD":/app treeder/bump $BUMP
version="$(cat VERSION)"
echo "version: $version"

# build
./build.sh

# tag
git checkout -b "rel_$version"
git commit -am "release $version"
git tag -a "$version" -m "version $version"
git push
git push --tags

docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version

# push
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version