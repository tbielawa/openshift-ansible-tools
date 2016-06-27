#!/bin/sh
#
echo -e "n\np\n1\n\n\nw\n" | fdisk /dev/vdb
pvcreate /dev/vdb1
vgextend VolGroup00 /dev/vdb1
lvextend -l +100%FREE /dev/mapper/VolGroup00-LogVol00
resize2fs /dev/mapper/VolGroup00-LogVol00

