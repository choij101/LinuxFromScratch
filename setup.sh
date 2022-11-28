#!/bin/bash
# Create LFS variable, should be exported for every shell
export LFS=/mnt/lfs
# mount partitions
mkdir -pv $LFS
mount -v -t ext4 /dev/sda3 $LFS
mkdir -v $LFS/home
mount -v -t ext4 /dev/sda4 $LFS/home
/sbin/swapon -v /dev/sda2
