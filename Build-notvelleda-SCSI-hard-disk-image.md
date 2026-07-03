### Build notvelleda SCSI hard disk image

Since the installer places the ext2 filesystem starting at sector 16, the loop device is created with an offset of 16 × 512 bytes before running mkfs.ext2:<br>
Accordingly, buildntvfs.sh was modified as follows:<br>
PARTLOOP=$(sudo losetup -f --show -o $((16*512)) "$FILE") || quit true<br>
sudo mkfs.ext2 -O none -I 128 "$PARTLOOP" || quit true<br>

Run buildntvfs.sh to build the root filesystem disk image. The resulting image file is root.img

<img width="962" height="673" alt="1" src="https://github.com/user-attachments/assets/088a61db-7c5e-4b41-8275-5a8ea7d12469" />

<img width="962" height="673" alt="2" src="https://github.com/user-attachments/assets/dadf3841-17a1-4d1c-8c8c-f5355c8db729" />

<img width="962" height="673" alt="3" src="https://github.com/user-attachments/assets/4d859245-1c81-4673-86f6-6b19c744791c" />

During the partition check, the kernel found the sda1 partition and mounted the ext2 filesystem as the root filesystem.
