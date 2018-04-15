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
./yocto-docker/docker-bake.sh core-image-minimal
```

Build Docker image
------------------

```
git clone git@github.com:3mdeb/yocto-docker.git
docker build -t 3mdeb/yocto-docker yocto-docker
```
