# Bash Script To Compile and Install SIPWise RTPEngine On RedHat Based Systems
# Tested on Fedora 23, x86_64, Kernel: 4.2.6-3
# Author: Binan AL Halabi

#! /bin/sh

# Install Some Packages
dnf -y install git glib2 glib2-devel gcc zlib zlib-devel openssl openssl-devel pcre pcre-devel libcurl libcurl-devel xmlrpc-c xmlrpc-c-devel

dnf -y install hiredis hiredis-devel


# Get the RTPEngine Source
cd /usr/local/src/
git clone https://github.com/sipwise/rtpengine.git

# Compile the daemon
cd rtpengine/daemon;make

# Install the daemon
cp rtpengine /usr/sbin/rtpengine

# Install the header files of the iptables
dnf -y install iptables-devel
# Compile and Install The iptables extension "libxt_RTPENGINE"
cd /usr/local/src/rtpengine/iptables-extension;make
# Install the extension
cp libxt_RTPENGINE.so /lib64/xtables

# Install the kernel header files
dnf -y install kernel-devel-$(uname -r)
kernelD="/usr/lib/modules/$(uname -r)/build/"
if [ ! -d $kernelD ]; then
	echo "Could Not Find the Kernel Headers For The current Kernel.\n"
	exit
fi

# Compile and Install the kernel module "xt_RTPENGINE"
cd /usr/local/src/rtpengine/kernel-module;make
cp xt_RTPENGINE.ko "/lib/modules/$(uname -r)/extra"

# Create a list of modules dependencies
depmod  -a

