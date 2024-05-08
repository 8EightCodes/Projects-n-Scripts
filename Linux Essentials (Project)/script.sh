#!/bin/bash


mkdir _support
mkdir _support/Log
mkdir _support/hardware
mkdir _support/OS
mkdir _support/Network


# Copy log files
cp /var/log/*.log _support/Log



# Get hardware information
# CPU
lscpu >> _support/hardware/CPU_info.txt
# Memory
free -m | grep 'Mem' >> _support/hardware/Memory_info.txt
# Storage (list disks)
lsblk -d >> _support/hardware/Storage_info.txt
# Peripheral devices (USB)
lsusb >> _support/hardware/USB_info.txt


# Get OS information
# Kernel version
uname -a >> _support/OS/os_info.txt
# Distribution info
lsb_release -a >> _support/OS/os_info.txt
# Users list (non-root)
cut -d: -f1-3 /etc/passwd | grep -Ev '^root' >> _support/OS/users_info.txt
# Processes 
ps aux -e  >> _support/OS/Processes_info.txt


# Get network information
# Network interfaces (active)
ip addr show  >> _support/Network/Interface_info.txt
# Routing table
ip route show >> _support/Network/route_info.txt
# DNS information
cat /etc/resolv.conf >> _support/Network/DNS_info.txt
# Network check (ping example)
ping -c 4 8.8.8.8 >> _support/Network/Ping_info.txt


# Create timestamp for archive filename
timestamp=$(date +%Y-%m-%d_%H%M%S)
# Create archive file
tar -czvf support-${timestamp}.tar.gz _support


# Inform user about completion
echo "Support archive created: support-${timestamp}.tar.gz"
