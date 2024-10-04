#!/bin/bash

root="$(pwd)"
poky="$root/poky"
oe="$root/meta-openembedded"
stm32mp="$root/meta-st-stm32mp"

oe_dependencies="meta-oe meta-python"

source $poky/oe-init-build-env


echo "setting up build directory.."
for dep in $oe_dependencies
do
	echo "Adding layer $oe/$dep.."
	bitbake-layers add-layer $oe/$dep
done

echo "Adding layer $stm32mp.."
bitbake-layers add-layer $stm32mp

bitbake core-image-minimal -D MACHINE="stm32mp157d-dk1" -D ACCEPT_EULA_stm32mp157c-dk2="1"
