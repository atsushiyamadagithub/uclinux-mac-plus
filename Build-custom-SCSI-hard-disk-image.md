## Boot Procedure for Custom SCSI hard disk image

### Build the ext2 root filesystem
1. Change to the user directory and run **build.sh** to build the root filesystem.
2. Run **buildfs.sh** to build the root filesystem disk image. The resulting image file is root.img.<br>
   This custom user/buildfs.sh script builds an ext2 root filesystem image on /dev/sda without a Macintosh partition map.<br>
   The kernel is booted from the floppy image, and the ext2 filesystem is used as the root filesystem.
   
3. Change to the uClinux directory and run **buildbf.sh** to build the boot floppy image.<br>
   The resulting image file is floppy.img.

### Start MAME
mame macplus -hard1 root.img -flop1 floppy.img

Wait for the kernel to boot
Confirm that the msh shell prompt appears

<img width="962" height="673" alt="4" src="https://github.com/user-attachments/assets/f0a184d4-24ce-4809-bb0e-075c799bd059" />

The screenshot above shows loading the kernel.

<img width="962" height="673" alt="7" src="https://github.com/user-attachments/assets/5438d0a4-8196-4ec3-8a98-dbe7cd9896a6" />

The screenshot above shows the kernel is starting.

<img width="962" height="673" alt="6" src="https://github.com/user-attachments/assets/3c95b74f-93d4-40f8-973c-bf500af220df" />

The screenshot above shows successful startup of the system and arrival at the shell prompt.
