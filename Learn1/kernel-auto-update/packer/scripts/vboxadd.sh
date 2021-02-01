#!/bin/bash

 sudo yum groupinstall "Development Tools" -y
 sudo yum install make gcc kernel-headers kernel-devel glibc-headers glibc-devel perl dkms bzip2 wget elfutils-libelf-devel -y
 sudo yum install epel-release
 sudo yum install dkms
 sudo mount VBoxGuestAdditions.iso -o loop /mnt/
 cd /mnt
 sudo sh /mnt/VBoxLinuxAdditions.run  --nox11