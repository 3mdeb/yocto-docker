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
