#!/bin/sh

# yay -S qemu qemu-arch-extra cpio

# cloning buildroot for vanilla kernel
git clone https://github.com/buildroot/buildroot
# cloning remarkable-mfgtools for rootfs
git clone https://github.com/ryzenlover/remarkable-mfgtools

# building i.MX6 vanilla kernel (takes an hour)
cd buildroot
unset PERL_MM_OPT
make imx6-sabresd_qt5_defconfig
make linux-build
cd -

# extracting rootfs
cd "remarkable-mfgtools/Profiles/MX6SL Linux Update/OS Firmware/files"
rm -rf rootfs
mkdir rootfs
tar -xvf rootfs.tar.gz -C rootfs
rm -rf rootfs/home/root
tar -xvf home.tgz -C rootfs/home

# customizing rootfs
rm rootfs/etc/fstab
cp -a ../../../../../files/fstab rootfs/etc/fstab
rm rootfs/etc/systemd/system/multi-user.target.wants/{dhcpcd.service,wpa_supplicant*}

# creating rootfs.img
rm rootfs.img
dd if=/dev/zero of=rootfs.img bs=1M count=1024
mkfs.ext4 -F -L linuxroot rootfs.img
mkdir mnt
sudo mount -o loop rootfs.img ./mnt
sudo cp -a rootfs/* ./mnt
sudo umount ./mnt
cd -

rm zImage zero-gravitas.dtb rootfs.img
ln -s buildroot/output/build/linux-4.19.16/arch/arm/boot/zImage
ln -s buildroot/output/build/linux-4.19.16/arch/arm/boot/dts/imx6q-sabresd.dtb zero-gravitas.dtb
ln -s "remarkable-mfgtools/Profiles/MX6SL Linux Update/OS Firmware/files/rootfs.img"
