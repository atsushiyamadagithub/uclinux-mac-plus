#!/bin/sh

FILE=floppy.img
MOUNTDIR=__mountdir
DEVICE=/dev/loop0
PARTITION=${DEVICE}p1
FSDIR=rootdir
OVERLAYDIR=rootdir-overlay
SIZE=64M
KERNEL_PATH=../uClinux/images/kernel
CMDLINE_FILE=cmdline
BOOTLOADER_DIR=../bootloader

unmount() {
    sudo umount "$MOUNTDIR"
    sudo losetup -d "$DEVICE"
    rm -r "$MOUNTDIR"
}

quit() {
    if [ "$1" = "true" ]; then
        echo "Quitting on error..."
    fi
    unmount
    exit
}

#echo "Building bootloader installer..."
#make -C $BOOTLOADER_DIR installer || quit true

echo "Creating it..."
dd if=/dev/zero of=$FILE bs=1024 count=800

echo "Creating filesystem..."
mke2fs -t ext2 -b 1024 -O none -I 128 $FILE
dd if=../bootloader/boot_block.bin of=$FILE bs=1024 count=1 conv=notrunc 

echo "Mounting..."
sudo rm -r $MOUNTDIR/*
mkdir -p $MOUNTDIR 
sudo mount -o loop $FILE $MOUNTDIR

#echo "Copying files..."
#sudo cp -rv $FSDIR/* "$MOUNTDIR" || quit true
#sudo ln -s /var/tmp "$MOUNTDIR/tmp"

echo "Generate romfs..."
genromfs -v -V ROMdisk -f romfs.img -d romfs

echo "Copying files for bootloader..."

#sudo cp "$KERNEL_PATH" "$MOUNTDIR/" || quit true
sudo cp ../uClinux/images/kernel "$MOUNTDIR/"

#sudo cp "$CMDLINE_FILE" "$MOUNTDIR/" || quit true
echo -n "rw init=/bin/sh" | sudo tee __mountdir/cmdline

sudo cp romfs.img "$MOUNTDIR/"

echo "Unmounting..."
sync
sudo umount "$MOUNTDIR"

echo "Done"
