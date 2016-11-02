#!/bin/bash

docker run --rm -it \
-v $(pwd):$(pwd) \
-v ~/.ssh:/home/build/.ssh \
-v ~/.gitconfig:/home/build/.gitconfig \
3mdeb/yocto-docker \
/bin/bash -c "cd $(pwd) && source oe-init-build-env && devtool $*"
