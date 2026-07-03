This repository is a fork of the original work by notvelleda.
My goal is to boot uClinux on a Macintosh Plus emulated by MAME and reach a working shell prompt.
The kernel boots correctly, starts init, and launches the shell.

## Environment

### Emulator

- MAME 0.285 (LLP64)
- Machine: Macintosh Plus (`macplus`)

### Disk Image

- Boot kernel floppy image and custom SCSI hard disk image
- Boot kernel and custom ROMFS floppy disk image
- Kernel and root filesystem SCSI hard disk image prepared from notvelleda repository

### Boot Procedure for Custom SCSI hard disk image

1. Change to the buildenv directory and run build.sh to build the Docker build environment
2. Create a `bootloader` directory alongside the `uClinux` and `user` directories, and copy the original bootloader files from notvelleda's repository into it.
3. Run build.sh to build the notvelleda uClinux kernel

   Added "moveal #0x003f1ffc, %sp" to uClinux/linux-2.0.x/arch/m68knommu/platform/68000/MacPlus/crt0_ram.S

   The bootloader should set the stack pointer according to the actual Mac Plus memory size, rather than simply using MemTop
   
4. Change to the user directory and run build.sh to build the root filesystem
5. Run buildfs.sh to build the root filesystem disk image. The resulting image file is root.img

   This custom user/buildfs.sh script builds an ext2 root filesystem image on /dev/sda without a Macintosh partition map.
   The kernel is booted from the floppy image, and the ext2 filesystem is used as the root filesystem.
   
6. Change to the uClinux directory and run buildbf.sh to build the boot floppy image. The resulting image file is floppy.img
7. Start MAME:   mame macplus -hard1 root.img -flop1 floppy.img

Wait for the kernel to boot
Confirm that the msh shell prompt appears

### Current Status

 Successfully reached the `msh` shell prompt.
The kernel is booted from the floppy image, and the ext2 filesystem is used as the root filesystem.

<img width="962" height="673" alt="4" src="https://github.com/user-attachments/assets/f0a184d4-24ce-4809-bb0e-075c799bd059" />

The screenshot above shows loading the kernel.

<img width="962" height="673" alt="7" src="https://github.com/user-attachments/assets/5438d0a4-8196-4ec3-8a98-dbe7cd9896a6" />

The screenshot above shows the kernel is starting.

<img width="962" height="673" alt="6" src="https://github.com/user-attachments/assets/3c95b74f-93d4-40f8-973c-bf500af220df" />

The screenshot above shows successful startup of the system and arrival at the shell prompt.

### Boot Procedure for romfs floppy image

1. Run docker container following command for kernel build environment  

   docker run -it --rm --user $(id -u):$(id -g) --mount type=bind,source="$(pwd)",target=/linux --workdir /linux -e TERM=xterm-256color uclinux-buildenv:0.1 bash

2. menuconfig
   make ARCH=m68knommu CROSS_COMPILE=m68k-elf- menuconfig

   Kernel/Library/Defaults Selection  --->

   Customize Kernel Settings

   Floppy, IDE, and other block devices

   <*> ROM disk memory block device

   Filesystems  --->

   <*> ROM filesystem support

   Exit and Save

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

### Boot Procedure for notvelleda SCSI hard disk image

Since the installer places the ext2 filesystem starting at sector 16, the loop device is created with an offset of 16 × 512 bytes before running mkfs.ext2:<br>
Accordingly, nbuildfs.sh was modified as follows:<br>
PARTLOOP=$(sudo losetup -f --show -o $((16*512)) "$FILE") || quit true<br>
sudo mkfs.ext2 -O none -I 128 "$PARTLOOP" || quit true<br>

<img width="962" height="673" alt="1" src="https://github.com/user-attachments/assets/088a61db-7c5e-4b41-8275-5a8ea7d12469" />

<img width="962" height="673" alt="2" src="https://github.com/user-attachments/assets/dadf3841-17a1-4d1c-8c8c-f5355c8db729" />

<img width="962" height="673" alt="3" src="https://github.com/user-attachments/assets/4d859245-1c81-4673-86f6-6b19c744791c" />

During the partition check, the kernel found the sda1 partition and mounted the ext2 filesystem as the root filesystem.

### Notes

This work was performed while investigating:

- Macintosh Plus boot process
- bootloader behavior
- SCSI driver operation
- uClinux 2.0.x kernel internals
- m68k bootloader code
- MAME debugging
- Early userspace startup sequence
- Acknowledgements

Many technical challenges were solved through extensive discussions with ChatGPT.

ChatGPT provided guidance on:

- m68k assembly analysis
- uClinux kernel internals
- bootloader investigation
- filesystem image creation
- debugging techniques
- MAME debugger usage
- reverse engineering of historical Macintosh Linux components


Its assistance significantly accelerated the investigation and development process.

Credits

Original project:
https://github.com/notvelleda/uclinux-mac-plus

Special thanks to notvelleda for making the original source code available.
