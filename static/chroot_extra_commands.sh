#!/bin/bash

HOME=/root
SKYWIRE_DIR=${HOME}/skywire
export HOME
export SKYWIRE_DIR

# function to log messages as info
function info() {
    printf '\033[0;32m[ Info ]\033[0m %s\n' "${1}"
}

# Chroot extra commands. This allow us to pass some extra commands
# inside the chroot, for example to install/remove additional pkgs
# or execute some bash commands

# by default update the es_US locales
info "Re-generating the locales info for en_US.UTF-8"
locale-gen en_US.UTF-8

# apt-get commands (install/remove/purge)
# modify and un-comment
info "Updating your system via APT"
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y install jq
#apt-get -y remove --purge [your_pkgs_here]
# keep this on the very end of this block
info "Cleaning the APT cache to make a smaller image"
apt-get clean

# forge a time on the system to avoid fs dates are in the future
info "Setting the chroot clock to now to avoid bugs with the date"
/sbin/fake-hwclock save force

# your custom commands here