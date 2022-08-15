#!/bin/bash
# This script is designed to get the webcam working on Macbook Air A1466 with an EMC # of 2925
# It may not work for A1466 Macbook Air laptops with a different EMC # as these are made different
# years with different hardware.
#
# Tested with Xubuntu 20.04
#
### Important:  Run this Script as a normal user
#
# by Charles McColm, chaslinux@gmail.com, August 12, 2022

### Install Firmware ###

sudo apt install git curl cpio
mkdir -p ~/Code
cd ~/Code
git clone https://github.com/patjak/facetimehd-firmware.git
cd facetimehd-firmware
make
sudo make install

### Install webcam ###
kernel=$(uname -r)
kernel="linux-headers-$kernel"

sudo apt -y install $kernel git kmod libssl-dev checkinstall
cd ~/Code
git clone https://github.com/patjak/bcwc_pcie.git
cd bcwc_pcie
make
sudo checkinstall
cd ~/Code/bcwc_pcie/

### determine the .deb name ###
wireless=$(ls | grep 'amd64.deb')

### Install the created .deb file and the drivers ###

sudo dpkg -i $wireless
sudo dpkg -i bcwc-pcie_20220812-1_amd64.deb
sudo depmod
sudo modprobe facetimehd

