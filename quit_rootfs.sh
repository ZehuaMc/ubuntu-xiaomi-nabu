#!/bin/sh
if uname -m | grep -q aarch64
then
  echo "cancel qemu install for arm64"
else
  #Remove qemu emu
  echo -1 | tee /proc/sys/fs/binfmt_misc/aarch64
  echo -1 | tee /proc/sys/fs/binfmt_misc/aarch64ld
  rm rootdir/qemu-aarch64-static
  rm qemu-aarch64-static
fi

umount rootdir/sys
umount rootdir/proc
umount rootdir/dev/pts
umount rootdir/dev
umount rootdir

rm -d rootdir

echo "quit rootfs done!"

