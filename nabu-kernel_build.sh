git clone https://gitlab.postmarketos.org/panpanpanpan/sm8150-mainline.git --branch=sm8150-6.13 --depth 1 linux
cd linux
git applu ../patch/ufs.patch
git apply ../patch/ln8000_v9.patch
git apply ../patch/rtc.patch
export ARCH=arm64 LLVM=1 LLVM_IAS=1
make -j$(nproc) defconfig sm8150.config
make -j$(nproc) Image Image.gz dtbs modules
_kernel_version="$(make kernelrelease -s)"
# mkdir ../linux-xiaomi-nabu/boot
# cp arch/arm64/boot/Image.gz ../linux-xiaomi-nabu/boot/vmlinuz-$_kernel_version
# cp arch/arm64/boot/dts/qcom/sm8150-xiaomi-nabu.dtb ../linux-xiaomi-nabu/boot/dtb-$_kernel_version
sed -i "s/Version:.*/Version: ${_kernel_version}/" ../linux-xiaomi-nabu/DEBIAN/control
rm -rf ../linux-xiaomi-nabu/lib
make modules_install INSTALL_MOD_PATH=../linux-xiaomi-nabu
# rm ../linux-xiaomi-nabu/lib/modules/**/build
cd ..
cat linux/arch/arm64/boot/Image.gz linux/arch/arm64/boot/dts/qcom/sm8150-xiaomi-nabu.dtb > zImage
#rm -rf linux

git clone https://android.googlesource.com/platform/system/tools/mkbootimg
./mkbootimg/mkbootimg.py --kernel zImage --cmdline "pd_ignore_unused clk_ignore_unused console=tty0 root=/dev/sda32 rw rootwait" --base 0x00000000 --kernel_offset 0x00008000 --tags_offset 0x00000100 --pagesize 4096 --id -o linux.boot.img
#rm -rf mkbootimg

dpkg-deb --build --root-owner-group linux-xiaomi-nabu
dpkg-deb --build --root-owner-group firmware-xiaomi-nabu
dpkg-deb --build --root-owner-group alsa-xiaomi-nabu
