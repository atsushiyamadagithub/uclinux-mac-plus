If you build the kernel using `make menuconfig`, be sure to enable:

File systems
    <*> ROM file system support (CONFIG_ROMFS_FS)

Without this option, the kernel will panic with:

Kernel panic: VFS: Unable to mount root fs on 1f:00
