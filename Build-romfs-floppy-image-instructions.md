## Boot Procedure for Custom ROMFS image

### Patch to the boot_block

```patch -p0 < boot_block-romfs.patch```

### Build the kernel

1.  Patch to uClinux/linux-2.0.x/drivers/block/blkmem.c
```patch -p0 < blkmem-romfs.patch```

2. Run docker container following command for kernel build environment<br>
```docker run -it --rm --user $(id -u):$(id -g) --mount type=bind,source="$(pwd)",target=/linux --workdir /linux -e TERM=xterm-256color uclinux-buildenv:0.1 bash```

3. Customize kernel settings foe ROMFS<br>
   ```make ARCH=m68knommu CROSS_COMPILE=m68k-elf- menuconfig```<br>
   Select Kernel/Library/Defaults Selection  --->
<img width="859" height="410" alt="1" src="https://github.com/user-attachments/assets/83810055-28e8-4465-895e-a5cb68d6ed98" />
   <br>    Select Customize Kernel Settings<br>
<img width="859" height="410" alt="2" src="https://github.com/user-attachments/assets/8c411c13-6e81-41bc-a5a6-2035599fc2a4" />
<img width="859" height="410" alt="3" src="https://github.com/user-attachments/assets/91d26204-fe3f-478c-ba9e-2c999a727ec2" />

   be sure to enable: ROM disk memory block device

   <img width="859" height="410" alt="ROM disk memory block device" src="https://github.com/user-attachments/assets/fe7c2b6b-3fc0-41c1-ae0c-bdcb36e068f1" />

   be sure to enable: ROM filesystem support

   <img width="859" height="410" alt="ROM filesystem support" src="https://github.com/user-attachments/assets/5fe59560-985a-4f6c-9c80-7e5cc17a8fd7" />

<img width="859" height="410" alt="4" src="https://github.com/user-attachments/assets/af9a96c5-147e-420b-914f-40cc48497739" />

   Exit and Save
   
4.
   ```make ARCH=m68knommu CROSS_COMPILE=m68k-elf- clean```<br>
   ```make ARCH=m68knommu CROSS_COMPILE=m68k-elf- dep```<br>
   ```make ARCH=m68knommu CROSS_COMPILE=m68k-elf-```<br>
   
5. Run build.sh to build the notvelleda uClinux kernel<br>
   I added "moveal #0x003f1ffc, %sp" to uClinux/linux-2.0.x/arch/m68knommu/platform/68000/MacPlus/crt0_ram.S<br>
   The bootloader should set the stack pointer according to the actual Mac Plus memory size, rather than simply using MemTop

### Build the romfs filesystem

1. Change to the user directory and run buildr.sh to build the romfs filesystem
2. Run buildrfs.sh to build the romfs filesystem disk image. The resulting image file is romfs.img

   This custom user/buildrfs.sh script builds an romfs filesystem image.
   The kernel is booted from the floppy image, and the romfs filesystem is used as the root filesystem.
   
3. Change to the uClinux directory and run buildbf.sh to build the boot floppy image. The resulting image file is floppy.img

### Start MAME
mame macplus -flop1 floppy.img

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
