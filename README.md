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

1. Run buildenv/build.sh to build the Docker build environment
2. Run user/buildbbb.sh to build the notvelleda bootloader.
3. Run uClinux/buildbf.sh to build the boot floppy image. 
4. Add "moveal #0x003f1ffc, %sp" to uClinux/linux-2.0.x/arch/m68knommu/platform/68000/MacPlus/crt0_ram.S   

   The bootloader should set the stack pointer according to the actual Mac Plus memory size, rather than simply using MemTop.

5. Run uClinux/build.sh to build the notvelleda uClinux kernel.
6. Run user/buildfs.sh to build the root filesystem to the EXT2 SCSI disk image.
7. Start MAME:   mame macplus -hard1 rootfs.img -flop1 floppy.img -debug

Wait for the kernel to boot.
Confirm that the msh shell prompt appears.

### Current Status

 Successfully reached the `msh` shell prompt.

<img width="962" height="673" alt="4" src="https://github.com/user-attachments/assets/f0a184d4-24ce-4809-bb0e-075c799bd059" />

<img width="962" height="673" alt="0" src="https://github.com/user-attachments/assets/2597ab20-ecac-45a9-9340-85ec8ab4eb7e" />

<img width="962" height="673" alt="3" src="https://github.com/user-attachments/assets/d89a15b2-01c3-404e-a480-564b1a540ecb" />

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
