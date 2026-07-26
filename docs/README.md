[uclinux-mac-plus](https://github.com/atsushiyamadagithub/uclinux-mac-plus)
This repository is a fork of the original work by notvelleda.
My goal is to boot uClinux on a Macintosh Plus emulated by MAME and reach a working shell prompt.
The kernel boots correctly, starts init, and launches the shell.

## Environment

### Emulator

- MAME 0.285 (LLP64)
- Machine: Macintosh Plus (`macplus`)

### Disk Images

- Boot kernel floppy image and custom SCSI hard disk image
- Boot kernel and custom ROMFS floppy disk image
- Kernel and root filesystem SCSI hard disk image prepared from notvelleda repository

Prebuilt disk images are available for all supported boot configurations.
- [mame-images](mame-images)

## Current Status

Successfully reached the msh shell prompt using all of the following boot configurations:

* Booting from a kernel floppy image with a custom SCSI hard disk image (ext2 root filesystem)
* Booting from a kernel + custom ROMFS floppy disk image (ROMFS root filesystem)
* Booting from a SCSI hard disk image containing both the kernel and the root filesystem, prepared from the notvelleda repository

<img width="962" height="673" alt="4" src="https://github.com/user-attachments/assets/f0a184d4-24ce-4809-bb0e-075c799bd059" />
<img width="962" height="673" alt="7" src="https://github.com/user-attachments/assets/5438d0a4-8196-4ec3-8a98-dbe7cd9896a6" />
<img width="962" height="673" alt="6" src="https://github.com/user-attachments/assets/3c95b74f-93d4-40f8-973c-bf500af220df" />

## To build the kernel or the root filesystem
You need Docker and the provided build environment.
1. Change to the buildenv directory and run **build.sh** to build the Docker build environment
2. Create a `bootloader` directory alongside the `uClinux` and `user` directories, and copy the original bootloader files from notvelleda's repository into it.
3. Patch to the bootloader/boot_block.s
   
   ```patch -p0 < boot_block.patch```

   Patch files are located in the patches directory.

   The bootloader sets the stack pointer according to the actual Mac Plus memory size, using MemTop

4. Patch to to uClinux/linux-2.0.x/arch/m68knommu/platform/68000/MacPlus/crt0_ram.S

   ```patch -p0 < crt0_ram.patch```

5. Run **uClinux/build.sh** to build the notvelleda uClinux kernel

   You are ready to build disk images.

## Build disk images
You can build the following boot configurations
  - [Build custom SCSI hard disk image](Build-custom-SCSI-hard-disk-image.md)
  - [Build notvelleda SCSI hard disk image](Build-notvelleda-SCSI-hard-disk-image.md)
  - [Build romfs floppy image instructions](Build-romfs-floppy-image-instructions.md)

## Notes

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
