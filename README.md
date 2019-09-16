# remarkable-dev

This project intends to create a proper development environment for reMarkable

## QtCreator in a docker

To build and start the pre-set QtCreator image:

```
docker-compose --file docker/qtcreator/qt.docker-compose.yml up --build
```

Make sure you've set up your ssh keys. 

## resources

### official

- remarkable SDK: https://remarkable.engineering/deploy/sdk/
- filesystem description: https://remarkablewiki.com/tech/filesystem
- eink driver: https://github.com/reMarkable/linux/blob/137ec479df0252a6483ee4d90912dcda66330b8a/arch/arm/mach-pxa/am200epd.c

### community

- https://github.com/torwag/remarkableflash
- https://plasma.ninja/blog/devices/remarkable/2017/12/18/reMarkable-exporation.html
- https://github.com/ryzenlover/remarkable-mfgtools
- http://www.davisr.me/projects/remarkable-microsd/

### tools

- https://github.com/dockcross/dockcross

### documentation

#### emulating raspberry

- https://www.supinfo.com/articles/single/5429-emuler-une-raspberry-pi-linux-avec-qemu
- http://www.jdhp.org/docs/tutoriel_rpi_qemu/tutoriel_rpi_qemu.html
- https://azeria-labs.com/emulate-raspberry-pi-with-qemu/
- https://raspberrypi.stackexchange.com/questions/165/emulation-on-a-linux-pc
- https://github.com/wimvanderbauwhede/limited-systems/wiki/Raspbian-"stretch"-for-Raspberry-Pi-3-on-QEMU

#### creating Qemu machines

- https://connect.ed-diamond.com/GNU-Linux-Magazine/GLMF-148/Qemu-comment-emuler-une-nouvelle-machine-Cas-de-l-APF27

## research

- download mfgtools
- create a new image
  - `dd if=/dev/zero of=floppy.img bs=1k count=1000000`
  - `sudo losetup -fP floppy.img`
  - `mkfs.ext4 floppy.img`
- populate image
  - `mkdir mnt`
  - `sudo mount floppy.img ./mnt`
  - decompress mfgtools' rootfs
  - `cp -a` contents to the image
- install qemu and arm dependencies
- `./start.sh`
