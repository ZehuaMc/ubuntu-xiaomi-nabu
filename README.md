<img align="right" src="https://raw.githubusercontent.com/jiganomegsdfdf/ubuntu-xiaomi-nabu/master/ubnt.png" width="425" alt="Ubuntu 23.04 Running On A Xiaomi Pad 5">

# Ubuntu for Xiaomi Pad 5
This repo contians scripts for automatic building of ubuntu rootfs and kernel for Xiaomi Pad 5

# Where do i get needed files?
Actually, just go to the "Actions" tab, find one of latest builds and download file named **rootfs.img** and **linux.boot.img** 

# Update info
- Unpack .zip you downloaded
- Run `dpkg -i *-xiaomi-nabu.deb`
- Flash new boot.img `fastboot flash boot_ab linux.boot.img`

# Install info
- Unpack .zip you downloaded
- **rootfs.img** must be flashed to the partition named "**linux**"(**sda32**) `fastboot flash linux rootfs.img`
- Flash boot.img `fastboot flash boot_ab linux.boot.img`
- Password is `password`

