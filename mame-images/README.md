## Start MAME:
Prebuilt disk images are available in this directory.

mame macplus -hard1 root.img -flop1 boot-floppy-hddroot.img
The kernel is booted from the floppy image, and the ext2 filesystem is used as the root filesystem.

mame macplus -flop1 boot-floppy-romfs.img
The kernel is booted from the floppy image, and the romfs filesystem is used as the root filesystem.
