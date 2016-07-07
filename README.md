Build Docker image
------------------

```
docker build -t 3mdeb/yocto-docker .
```

Clone Poky and checkout
-----------------------

```
git clone git://git.yoctoproject.org/poky
cd poky
git checkout -b krogoth origin/krogoth
```

Build 

Build sample image
------------------

```
docker run --rm -it \
-v $(pwd):$(pwd) \
-v ~/.ssh:/home/build/.ssh \
-v ~/.gitconfig:/home/build/.gitconfig \
3mdeb/yocto-docker \
/bin/bash -c "cd $(pwd) && source oe-init-build-env && bitbake core-image-sato"
```
