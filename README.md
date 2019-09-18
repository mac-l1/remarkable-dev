# remarkable-dev

This project intends to create a proper development environment for reMarkable

## QtCreator in a docker

To build and start the pre-set QtCreator image:

```
docker-compose --file qtcreator/qt.docker-compose.yml up --build
```

Make sure you've set up your ssh keys. 

## Qemu

> Commands are extected to be run in ./qemu/

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
