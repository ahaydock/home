#!/bin/bash

# packages
PKGS='curl git git-flow nmap nmon tree vagrant vim vim-athena wget sysstat blktrace iotop'
# XPKGS='synergy geany geany-plugins pidgin pidgin-sipe conky'

# Install dotfiles
for F in .bashrc .profile .inputrc .vimrc .dircolors ; do
  wget --no-check-certificate https://raw.github.com/ahaydock/home/master/$F -O ~/$F
done

# Setup puppet repo
# PUPPET_URL="http://apt.puppetlabs.com/";
# DISTRIB_CODENAME=`awk -F= '/^DISTRIB_CODENAME/ { print $2 }' /etc/lsb-release`;
# PUPPET_REPO="puppetlabs-release-$DISTRIB_CODENAME.deb";
# /usr/bin/wget -O /tmp/$PUPPET_REPO $PUPPET_URL/$PUPPET_REPO 2>&1 >/dev/null;
# /usr/bin/dpkg -i /tmp/$PUPPET_REPO;

# install silently
echo force-confold >> /etc/dpkg/dpkg.cfg.d/force_confold;
DEBIAN_FRONTEND=noninteractive;
RUNLEVEL=1

# update and install packages
/usr/bin/apt-get update;
/usr/bin/apt-get -qq -y install $PKGS
unset RUNLEVEL

# Install graphical apps if xorg is installed
if /usr/bin/dpkg -l xorg >/dev/null ; then
  /usr/bin/apt-get -qq -y install $XPKGS
fi

