Docker container for Yocto builds
---------------------------------

[![Build Status](https://travis-ci.com/3mdeb/yocto-docker.svg?branch=master)](https://travis-ci.com/3mdeb/yocto-docker)

Clone Poky and checkout
-----------------------

```
git clone git://git.yoctoproject.org/poky
cd poky
git checkout -b krogoth origin/krogoth
```

Pull Docker image
-----------------

```
docker pull 3mdeb/yocto-docker
```

Build sample image
------------------

```
BUILD_DIR=build ./yocto-docker/docker-bake.sh core-image-minimal
```

Build Docker image
------------------

```
./build.sh
```

Release image to dockerhub
--------------------------

./release.sh VERSION_BUMP

`VERSION_BUMP` can be: `major`, `minor`, `patch`

Troubleshooting
----------------

If similar message appears:

```
dirname: missing operand
Try 'dirname --help' for more information.
dirname: missing operand
Try 'dirname --help' for more information.
```

It probably means that your `SSH key` is not exposed via the
[ssh-agent](https://linux.die.net/man/1/ssh-agent). In this case you could run:

```
eval `ssh-agent`
ssh-add
```
