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
  - [Build custom SCSI hard disk image](Build-custom-SCSI-hard-disk-image.md)
* Booting from a kernel + custom ROMFS floppy disk image (ROMFS root filesystem)
  - [Build romfs floppy image instructions](Build-romfs-floppy-image-instructions.md)
* Booting from a SCSI hard disk image containing both the kernel and the root filesystem, prepared from the notvelleda repository
  - [Build notvelleda SCSI hard disk image](Build-notvelleda-SCSI-hard-disk-image.md)

<img width="962" height="673" alt="4" src="https://github.com/user-attachments/assets/f0a184d4-24ce-4809-bb0e-075c799bd059" />
<img width="962" height="673" alt="7" src="https://github.com/user-attachments/assets/5438d0a4-8196-4ec3-8a98-dbe7cd9896a6" />
<img width="962" height="673" alt="6" src="https://github.com/user-attachments/assets/3c95b74f-93d4-40f8-973c-bf500af220df" />

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
