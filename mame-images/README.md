## Prebuilt disk images
Prebuilt disk images are available in this directory.

### Use ext2 root filesystem
mame macplus -hard1 root.img -flop1 boot-floppy-hddroot.img

The kernel is booted from the floppy image, and the ext2 filesystem is used as the root filesystem.
### Use romfs root filesystem
mame macplus -flop1 boot-floppy-romfs.img

The kernel is booted from the floppy image, and the romfs filesystem is used as the root filesystem.

### Use notvelleda root filesystem
mame macplus -hard1 notvelleda-root.img

The kernel is booted from the SCSI hard disk image, and the filesystem is used as the root filesystem.
