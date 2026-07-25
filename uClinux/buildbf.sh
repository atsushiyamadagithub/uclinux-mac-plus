#!/bin/sh
dd if=/dev/zero of=floppy.img bs=1024 count=800
mke2fs -t ext2 -b 1024 -O none -I 128 floppy.img
dd if=../bootloader/boot_block.bin of=floppy.img bs=1024 count=1 conv=notrunc
mkdir -p mnt
sudo mount -o loop floppy.img mnt
sudo cp images/kernel mnt/kernel
echo -n "root=/dev/sda rw init=/bin/sh" | sudo tee mnt/cmdline
sync
sudo umount mnt
