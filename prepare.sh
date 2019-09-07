#!/bin.sh

# yay -S qemu qemu-arch-extra

# cloning buildroot for vanilla kernel
git clone https://github.com/buildroot/buildroot
# cloning remarkable-mfgtools for rootfs
git clone https://github.com/ryzenlover/remarkable-mfgtools

# build i.MX6 vanilla kernel
cd buildroot
unset PERL_MM_OPT
make imx6-sabresd_qt5_defconfig
make linux-build
cd -

# extracting rootfs
cd "remarkable-mfgtools/Profiles/MX6SL Linux Update/OS Firmware/files"
mkdir rootfs
cp rootfs.tar.gz rootfs/
cd rootfs
tar -xvf rootfs.tar.gz
rm rootfs.tar.gz
cd ..

# creating rootfs.img
dd if=/dev/zero of=rootfs.img bs=1M count=1024
mkfs.ext4 -F -L linuxroot rootfs.img
mkdir mnt
sudo mount -o loop rootfs.img ./mnt
sudo cp -a rootfs/* ./mnt
sudo umount ./mnt
cd ../../../../

ln -s buildroot/output/build/linux-4.19.16/arch/arm/boot/zImage
ln -s buildroot/output/build/linux-4.19.16/arch/arm/boot/dts/imx6q-sabresd.dtb
ln -s remarkable-mfgtools/Profiles/MX6SL Linux Update/OS Firmware/files/rootfs.img
