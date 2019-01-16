#!/bin/bash

function printHelp {
    echo -e "Runs bitbake inside Yocto build container\n"
    echo -e "\t --extra-cmd \"flag1 flag2\" - pass optional flags for extra commands before bitbake starts\n"
    echo "Example:"
    echo "BUILD_DIR=build ./docker-bake --extra-cmd \"github git-ti\" core-image-minimal"
}

EXTRA_CMD=""
# this switch must not collide with bitbake switches
if [ "$1" = "--extra-cmd" ]; then
    for param in $2; do
        case $param in
            "github")
            EXTRA_CMD+="ssh -T -o StrictHostKeyChecking=no git@github.com;"
            ;;
            "gitlab")
            EXTRA_CMD+="ssh -T -o StrictHostKeyChecking=no git@gitlab.com;"
            ;;
            "git-ti")
            EXTRA_CMD+="ssh -T -o StrictHostKeyChecking=no git@git.ti.com;"
            ;;
            *)
            echo "Unknown flag"
            printHelp
            exit 1
            ;;
        esac
    done
    shift 2
fi

if [ -z $POKY_DIR ]; then
    POKY_DIR="$PWD"
    echo "[WARNING]: \"POKY_DIR\" variable not present in environment"
    echo "[WARNING]: Defaulting to POKY_DIR=\"$POKY_DIR\""
fi

if [ -z $BUILD_DIR ]; then
    BUILD_DIR="$POKY_DIR/build"
    echo "[WARNING]: \"BUILD_DIR\" variable not present in environment"
    echo "[WARNING]: Defaulting to BUILD_DIR=\"$BUILD_DIR\""
fi

if [ -z $SSH_AUTH_SOCK ]; then
    eval `ssh-agent`
    ssh-add
fi

docker run --rm -t \
-u $(id -u) \
-v $(pwd):$(pwd) \
-v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK  \
-v ~/.gitconfig:/home/build/.gitconfig \
3mdeb/yocto-docker \
/bin/bash -c " \
              ${EXTRA_CMD} \
              cd $POKY_DIR && source oe-init-build-env $BUILD_DIR && bitbake $*"
