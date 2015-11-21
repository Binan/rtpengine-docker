#! /bin/sh

# Bash Script To Compile and Install SIPWise RTPEngine On RedHat Based Systems
# Tested on Fedora 23, x86_64, Kernel: 4.2.6-3
# Author: Binan AL Halabi

src="/usr/local/src/"
rtpengineSRC="$src/rtpengine"
kernelBuild="/usr/lib/modules/$(uname -r)/build/"
extraModules="/lib/modules/$(uname -r)/extra"
xtablesModules="/lib64/xtables"
rtpengineBin="/usr/sbin"

# Install Some Packages
dnf -y install git glib2 glib2-devel gcc zlib zlib-devel openssl openssl-devel pcre pcre-devel libcurl libcurl-devel xmlrpc-c xmlrpc-c-devel

dnf -y install hiredis hiredis-devel


# Get the RTPEngine Source In The Folder $src
git clone https://github.com/sipwise/rtpengine.git $src

# Compile the daemon
cd "$rtpengineSRC/daemon";make

# Install the daemon, No "install" rule in th Makefile
cp -u rtpengine $rtpengineBin

# Install the header files of the iptables
dnf -y install iptables-devel

# Compile and Install The iptables extension "libxt_RTPENGINE"
cd "$rtpengineSRC/iptables-extension";make
# Install the extension
cp -u libxt_RTPENGINE.so "$xtablesModules"

# Install the kernel header files
dnf -y install kernel-devel-$(uname -r)
if [ ! -d $kernelBuild ]; then
	echo "Could Not Find the Kernel Headers For The current Kernel.\n"
	exit
fi

# Compile and Install the kernel module "xt_RTPENGINE"
cd "$rtpengineSRC/kernel-module";make
cp -u xt_RTPENGINE.ko $extraModules

# Create a list of modules dependencies
depmod  -a

