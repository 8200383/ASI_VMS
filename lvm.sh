#!bin/bash

# Delete LVM
#vgremove vgbin
#vgremove vgdados
#pvremove /dev/sdb
#pvremove /dev/sdc
#pvremove /dev/sdd

# Show disks
lsblk

# Create partitions
#parted /dev/sdb mkpart primary ext4 0% 300MB
#parted /dev/sdc mkpart primary ext4 0% 200MB
#parted /dev/sdc mkpart primary ext4 0% 100MB
#parted /dev/sdd mkpart primary ext4 0% 300MB

# Create physical volumes
pvcreate /dev/sdb1 /dev/sdc1 /dev/sdc2 /dev/sdd1

# Resize physical volume to give vgdados 100mb
#pvresize --setphysicalvolumesize 100M /dev/sdc

# Create volume groups
vgcreate vgbin /dev/sdb1 /dev/sdc1
vgcreate vgdados /dev/sdc2 /dev/sdd1

# Shows volume groups
vgs

# Shows physical volumes 
pvs

# Create logical volumes
lvcreate -n lv_bin -L 100M vgbin
lvcreate -n lv_log -L 200M vgbin
lvcreate -n lv_temp -L 100M vgbin
lvcreate -n lv_data1 -L 400M vgdados

# Show logical volumes
lvs
