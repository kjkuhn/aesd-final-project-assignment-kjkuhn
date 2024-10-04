#!/bin/bash

root="$(pwd)"
poky="$root/poky"
oe="$root/meta-openembedded"
stm32mp="$root/meta-st-stm32mp"
qt5="$root/meta-qt5"
stlinux="$root/meta-st-openstlinux"
MACHINE="stm32mp15-disco"
oe_dependencies="meta-oe meta-python meta-networking meta-multimedia meta-gnome meta-webserver meta-filesystems meta-perl meta-xfce"

source $poky/oe-init-build-env

layers=$(bitbake-layers show-layers)

echo "setting up build directory.."
for dep in $oe_dependencies
do
	if ! echo "$layers" | grep -q "$dep"; then
	    echo "Adding layer $oe/$dep.."
	    bitbake-layers add-layer $oe/$dep
	else
	    echo "Layer $dep already exists"
	fi
done

if ! echo "$layers" | grep -q "meta-qt5"; then
  echo "Adding $qt5.."
  bitbake-layers add-layer $qt5
fi

if ! echo "$layers" | grep -q "meta-st-stm32mp"; then
  echo "Adding layer $stm32mp.."
  bitbake-layers add-layer $stm32mp
fi

if ! echo "$layers" | grep -q "meta-st-openstlinux"; then
  echo "Adding layer $stlinux.."
  bitbake-layers add-layer $stlinux
fi




echo "updating bitbake settings in conf/local.conf..
"
# Lines to add to local.conf
lines=(
    "ACCEPT_EULA_$MACHINE = \"1\""
    "LICENSE_FLAGS_ACCEPTED += \"commercial\""
    "DISTRO_FEATURES:append = \" systemd usrmerge pam\""
    "DISTRO_FEATURES_BACKFILL_CONSIDERED += \"sysvinit\""
    "VIRTUAL-RUNTIME_init_manager = \"systemd\""
    "VIRTUAL-RUNTIME_initscripts = \"systemd-compat-units\""
    "MACHINE = \"$MACHINE\""
)

# Check and add each line
for line in "${lines[@]}"; do
    if ! grep -q "^${line}$" conf/local.conf; then
	echo "adding $line to conf/local.conf"
        echo "$line" >> conf/local.conf
    fi
done

echo "conf/local.conf updated successfully!"

bitbake st-image-weston
#bitbake st-image-weston -D MACHINE="stm32mp15-disco" -D ACCEPT_EULA_stm32mp15-disco="1"
