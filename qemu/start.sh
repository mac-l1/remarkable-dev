#!/bin/sh

qemu-system-arm \
  -M sabrelite \
  -m 512M \
  -display gtk \
  -kernel "zImage" \
  -append "console=ttymxc0 rootfstype=ext4 root=/dev/mmcblk2 rw init=/sbin/init" \
  -dtb "zero-gravitas.dtb" \
  -drive file="rootfs.img",format=raw,id=mmcblk2,cache=writethrough \
  -device sd-card,drive=mmcblk2 \
  -nic user \
  -vnc 0.0.0.0:1

  # -device bochs-display \
  # -initrd "initramfs.cpio.gz.uboot" \
  # -bios "files/u-boot.imx" \

# [ TIME ] Timed out waiting for device dev-ttyGS0.device.
# [DEPEND] Dependency failed for Serial Getty on ttyGS0.
# [ TIME ] Timed out waiting for device sys-subsystem-net-devices-usb0.device.
# [DEPEND] Dependency failed for udhcpd on usb0.

# [    0.713093] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 19, base_baud = 5000000) is a IMX
# [    0.732268] console [ttymxc0] enabled
# [    0.736333] phy index low: 1, phy index high: 2
# [  240.289647] INFO: task swapper:1 blocked for more than 120 seconds.
# [  240.290160]       Not tainted 4.1.28-zero-gravitas-01866-ge0b823726ea4-dirty #82
# [  240.290318] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
# [  240.290662] swapper         D 8051c44c     0     1      0 0x00000000
# [  240.292245] [<8051c44c>] (__schedule) from [<8051c73c>] (schedule+0x40/0x98)
# [  240.292473] [<8051c73c>] (schedule) from [<8051e7b8>] (schedule_timeout+0x114/0x168)
# [  240.292781] [<8051e7b8>] (schedule_timeout) from [<8051d248>] (wait_for_common+0x88/0x130)
# [  240.292953] [<8051d248>] (wait_for_common) from [<80262c74>] (imx_rng_init+0x158/0x2a8)
# [  240.293117] [<80262c74>] (imx_rng_init) from [<80262574>] (set_current_rng+0xc0/0x15c)
# [  240.293276] [<80262574>] (set_current_rng) from [<80262874>] (hwrng_register+0x190/0x1b8)
# [  240.293436] [<80262874>] (hwrng_register) from [<807c3fd8>] (imx_rng_probe+0xd4/0x134)
# [  240.293682] [<807c3fd8>] (imx_rng_probe) from [<802748e0>] (platform_drv_probe+0x44/0xac)
# [  240.293852] [<802748e0>] (platform_drv_probe) from [<802735ac>] (driver_probe_device+0x178/0x2b8)
# [  240.294009] [<802735ac>] (driver_probe_device) from [<802737bc>] (__driver_attach+0x8c/0x90)
# [  240.294158] [<802737bc>] (__driver_attach) from [<80271d50>] (bus_for_each_dev+0x68/0x9c)
# [  240.294352] [<80271d50>] (bus_for_each_dev) from [<802726bc>] (bus_add_driver+0x13c/0x1e4)
# [  240.294600] [<802726bc>] (bus_add_driver) from [<80273ed4>] (driver_register+0x78/0xf8)
# [  240.294843] [<80273ed4>] (driver_register) from [<807c434c>] (__platform_driver_probe+0x20/0x70)
# [  240.295092] [<807c434c>] (__platform_driver_probe) from [<807a9d78>] (do_one_initcall+0x118/0x1c4)
# [  240.295367] [<807a9d78>] (do_one_initcall) from [<807a9f48>] (kernel_init_freeable+0x124/0x1c4)
# [  240.295609] [<807a9f48>] (kernel_init_freeable) from [<8051883c>] (kernel_init+0x8/0xe8)
# [  240.295844] [<8051883c>] (kernel_init) from [<8000ef88>] (ret_from_fork+0x14/0x2c)

# reMarkable: ~/ cat /proc/cpuinfo
# processor    : 0
# model name    : ARMv7 Processor rev 10 (v7l)
# BogoMIPS    : 48.00
# Features    : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 
# CPU implementer    : 0x41
# CPU architecture: 7
# CPU variant    : 0x2
# CPU part    : 0xc09
# CPU revision    : 10
# Hardware    : Freescale i.MX6 SoloLite (Device Tree)
# Revision    : 0000
# Serial        : 123721d4ea9ce679

# remarkable-mfgtools/Profiles/MX6SL Linux Update/OS Firmware/
