#!/bin/bash

# Update Centos
sudo yum -y update

# Install repo
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh https://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

#  Install the latest long-term support kernel
sudo yum --enablerepo=elrepo-kernel install kernel-lt -y
sudo yum --enablerepo elrepo-kernel install kernel-lt-devel  -y

# Set Default Kernel Version
sed -i 's/.*GRUB_DEFAULT*.*/GRUB_DEFAULT=0/'  /etc/default/grub

# Update Grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Remove older kernels (Only for demo! Not Production!)
rm -f /boot/*3.10*

# Reboot VM
sudo  shutdown -r now

