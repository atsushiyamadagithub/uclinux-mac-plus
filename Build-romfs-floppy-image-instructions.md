If you build the kernel using `make menuconfig`, 

1. Run docker container following command for kernel build environment  

   docker run -it --rm --user $(id -u):$(id -g) --mount type=bind,source="$(pwd)",target=/linux --workdir /linux -e TERM=xterm-256color uclinux-buildenv:0.1 bash

2. make ARCH=m68knommu CROSS_COMPILE=m68k-elf- menuconfig

   Kernel/Library/Defaults Selection  --->

   Customize Kernel Settings

   be sure to enable: ROM disk memory block

<img width="859" height="410" alt="ROM disk memory block device" src="https://github.com/user-attachments/assets/fe7c2b6b-3fc0-41c1-ae0c-bdcb36e068f1" />

   be sure to enable: ROM filesystem support

   Exit and Save

<img width="859" height="410" alt="ROM filesystem support" src="https://github.com/user-attachments/assets/5fe59560-985a-4f6c-9c80-7e5cc17a8fd7" />

Without this option, the kernel will panic with:

Kernel panic: VFS: Unable to mount root fs on 1f:00

3. 
   make ARCH=m68knommu CROSS_COMPILE=m68k-elf- clean

   make ARCH=m68knommu CROSS_COMPILE=m68k-elf- dep

   make ARCH=m68knommu CROSS_COMPILE=m68k-elf-

4. Modify uClinux/linux-2.0.x/drivers/block/blkmem.c

--> 174
   #if defined(CONFIG_MAC_PLUS)
       #define CAT_ROMARRAY
   #endif

   #define ROOT_ARENA 0 --> 208

--> 313
#ifdef CAT_ROMARRAY
#if defined(CONFIG_MAC_PLUS)
	{0, 0x00300000, -1},
#else
	{0, 0, -1},
#endif
#define FIXUP_ARENAS \
	arena[0].address = 0x00300000;
#endif

5. Run build.sh to build the notvelleda uClinux kernel
   
6. Change to the user directory and run build.sh to build the romfs filesystem
7. Run buildfs.sh to build the romfs filesystem disk image. The resulting image file is romfs.img

   This custom user/buildfs.sh script builds an romfs filesystem image.
   The kernel is booted from the floppy image, and the romfs filesystem is used as the root filesystem.
   
8. Change to the uClinux directory and run buildbf.sh to build the boot floppy image. The resulting image file is floppy.img
9. Start MAME:   mame macplus -flop1 floppy.img

<img width="962" height="673" alt="1" src="https://github.com/user-attachments/assets/3b675c43-14ca-4335-9ea4-6ecb80cf2b1e" />

The screenshot above shows the kernel being loaded, followed by romfs.img.
The solid white progress bar indicates the kernel being loaded. The dotted black-and-white progress bar indicates romfs.img being loaded immediately afterward.

<img width="962" height="673" alt="2" src="https://github.com/user-attachments/assets/148696e0-9bc8-4f76-ae3e-237d3e5ac2a5" />

The screenshot above shows the kernel is starting.<br>
The following kernel boot messages appear when `ROM disk memory block device` is enabled in `Customize Kernel Settings, Floppy, IDE, and other block devices`:<br>
Blkmem copyright 1998,1999 D. Jeff Dionne<br>
Blkmem copyright 1998 Kenneth Albanowski<br>
Blkmem 1 disk images:<br>
0: 300000-347BFF (RO)<br>
You must enable ROM filesystem support in the kernel configuration to mount a ROMFS filesystem.<br>

<img width="962" height="673" alt="3" src="https://github.com/user-attachments/assets/0db4e247-e13a-4f3d-84ed-f1d2d810e81e" />

The kernel is booted from the floppy image, and the romfs filesystem is used as the root filesystem.
