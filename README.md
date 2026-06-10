This repository is a fork of the original work by notvelleda.
My goal is to boot uClinux on a Macintosh Plus emulated by MAME and reach a working shell prompt.
The kernel boots correctly, starts init, and launches the shell.

## Environment

### Emulator

- MAME 0.285 (LLP64)
- Machine: Macintosh Plus (`macplus`)

### Disk Image

- Custom SCSI hard disk image
- Linux kernel and root filesystem prepared from notvelleda repository

### Boot Procedure

1. Change to the buildenv directory and run build.sh to build the Docker build environment
2. Make directory bootloader and copy the notvelleda bootloader files to bootloader directory.
3. Run build.sh to build the notvelleda uClinux kernel

   I added "moveal #0x003f1ffc, %sp" to uClinux/linux-2.0.x/arch/m68knommu/platform/68000/MacPlus/crt0_ram.S

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

<img width="962" height="673" alt="4" src="https://github.com/user-attachments/assets/f0a184d4-24ce-4809-bb0e-075c799bd059" />

<img width="962" height="673" alt="7" src="https://github.com/user-attachments/assets/5438d0a4-8196-4ec3-8a98-dbe7cd9896a6" />

<img width="962" height="673" alt="6" src="https://github.com/user-attachments/assets/3c95b74f-93d4-40f8-973c-bf500af220df" />

The screenshot above shows successful startup of the system and arrival at the shell prompt.

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
