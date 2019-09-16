# remarkable-dev

This project intends to create a proper development environment for reMarkable

## QtCreator in a docker

To build and start the pre-set QtCreator image:

```
docker-compose --file docker/qtcreator/qt.docker-compose.yml up --build
```

Make sure you've set up your ssh keys. 

## Qemu

To prepare everything read and execute `./prepare.sh`, to start qemu run `./start.sh`

When the VM starts, login with `root`, then:

```bash
# because it fails and it triggers remarkable-fail which reboots
systemctl stop xochitl
systemctl disable xochitl
# start network
ifconfig eth0 up
dhcpcd
# install opkg
sh entware_install.sh
```

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
- https://stackoverflow.com/questions/57811916/emulating-the-remarkable-tablet-i-mx6-armv7-with-qemu

### tools

- https://github.com/dockcross/dockcross

### documentation

#### emulating raspberry

- https://www.supinfo.com/articles/single/5429-emuler-une-raspberry-pi-linux-avec-qemu
- http://www.jdhp.org/docs/tutoriel_rpi_qemu/tutoriel_rpi_qemu.html
- https://azeria-labs.com/emulate-raspberry-pi-with-qemu/
- https://raspberrypi.stackexchange.com/questions/165/emulation-on-a-linux-pc
- https://github.com/wimvanderbauwhede/limited-systems/wiki/Raspbian-"stretch"-for-Raspberry-Pi-3-on-QEMU

#### other

- https://www.imx6rex.com/open-rex/software/how-to-add-support-for-for-different-board-model/
- compile kernel for fb0: https://stackoverflow.com/questions/22066759/build-a-minimum-system-with-qt-embedded-and-run-on-qemu-for-x86

#### creating Qemu machines

- https://connect.ed-diamond.com/GNU-Linux-Magazine/GLMF-148/Qemu-comment-emuler-une-nouvelle-machine-Cas-de-l-APF27
