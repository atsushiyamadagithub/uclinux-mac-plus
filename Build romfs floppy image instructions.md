If you build the kernel using `make menuconfig`, be sure to enable:

<img width="859" height="410" alt="ROM filesystem support" src="https://github.com/user-attachments/assets/5fe59560-985a-4f6c-9c80-7e5cc17a8fd7" />

File systems
    <*> ROM file system support (CONFIG_ROMFS_FS)

Without this option, the kernel will panic with:

Kernel panic: VFS: Unable to mount root fs on 1f:00
<img width="859" height="410" alt="ROM disk memory block device" src="https://github.com/user-attachments/assets/fe7c2b6b-3fc0-41c1-ae0c-bdcb36e068f1" />
