#!/bin/bash

function printHelp {
    echo -e "Runs bitbake inside Yocto build container\n"
    echo -e "\t -e \"flag1 flag2\" - pass optional flags for extra commands before bitbake starts\n"
    echo "Example:"
    echo "./docker-bake -e \"github git-ti\" core-image-minimal"
}

EXTRA_CMD=""
# this switch must not collide with bitbake switches
if [ "$1" = "--extra-cmd" ]; then
    for param in $2; do
        case $param in
            "github")
            EXTRA_CMD+="ssh -T -o StrictHostKeyChecking=no git@github.com;"
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
        shift
    done
    shift 2
fi

docker run --rm -it \
-v $(pwd):$(pwd) \
-v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK  \
-v ~/.gitconfig:/home/build/.gitconfig \
3mdeb/yocto-docker \
/bin/bash -c " \
              ${EXTRA_CMD} \
              cd $(pwd) && source oe-init-build-env && bitbake $*"
