Docker container for Yocto builds
---------------------------------

[![Build Status](https://travis-ci.com/3mdeb/yocto-docker.svg?branch=master)](https://travis-ci.com/3mdeb/yocto-docker)

Clone Poky and checkout
-----------------------

```
git clone git://git.yoctoproject.org/poky
cd poky
git checkout -b zeus origin/zeus
```

Build sample Yocto image
------------------------

```
./yocto-docker/docker-bake.sh core-image-minimal
```

Pull Docker image
-----------------

```
docker pull 3mdeb/yocto-docker
```

Build Docker image
------------------

```
./build.sh
```

Release Docker image
--------------------

Refer to the
[docker-release-manager](https://github.com/3mdeb/docker-release-manager/blob/master/README.md)

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
