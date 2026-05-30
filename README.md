This repository is a fork of the original work by notvelleda.
My goal is to boot uClinux on a Macintosh Plus emulated by MAME and reach a working shell prompt.
The kernel boots correctly, starts init, and launches the shell.

## Environment

### Emulator

- MAME 0.285 (LLP64)
- Machine: Macintosh Plus (`macplus`)

### Disk Image

- Custom SCSI hard disk image
- Linux kernel and root filesystem prepared from this repository

### Boot Procedure

1. Build the notvelleda bootloader.
2. Build the notvelleda uClinux kernel.
3. Build the root filesystem image.
4. Create the Macintosh SCSI disk image.
5. Start MAME:
 (Windows command prompt)
 mame macplus -hard1 rootfs.img -flop1 floppy.img -debug
6. Wait for the kernel to boot.
7. Confirm that the msh shell prompt appears.

### Current Status

 Successfully reached the `msh` shell prompt.

<img width="962" height="673" alt="0" src="https://github.com/user-attachments/assets/2597ab20-ecac-45a9-9340-85ec8ab4eb7e" />

<img width="962" height="673" alt="1" src="https://github.com/user-attachments/assets/c62ef71a-0f6b-42be-a0d3-fc033c843205" />

<img width="962" height="673" alt="3" src="https://github.com/user-attachments/assets/d89a15b2-01c3-404e-a480-564b1a540ecb" />

The screenshot above shows successful startup of the system and arrival at the shell prompt.

### Notes

This work was performed while investigating:

Macintosh Plus boot process
bootloader behavior
SCSI driver operation
uClinux 2.0.x kernel internals
m68k bootloader code
MAME debugging
Early userspace startup sequence
Acknowledgements

Many technical challenges were solved through extensive discussions with ChatGPT.

ChatGPT provided guidance on:

m68k assembly analysis
uClinux kernel internals
bootloader investigation
filesystem image creation
debugging techniques
MAME debugger usage
reverse engineering of historical Macintosh Linux components


Its assistance significantly accelerated the investigation and development process.

Credits

Original project:
https://github.com/notvelleda/uclinux-mac-plus

Special thanks to notvelleda for making the original source code available.
