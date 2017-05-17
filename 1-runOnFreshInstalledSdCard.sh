#!/bin/bash

# The SD card should be connected to the host OS so /Volumes/boot is available

# go to the boot dir
pushd /Volumes/boot

# enable ssh access
touch ssh

# === Allow network access when USB plugged into a host machine
# make a backup in case need to redo this command
if [ ! -f ./config.txt.original ]
then
  cp -p config.txt config.txt.original
fi
# wipe out any previous changes
cp -p config.txt.original config.txt
# add the lines we need
echo "" >> config.txt
echo "# pxv: Part of allowing USB access to OS" >> config.txt
echo "dtoverlay=dwc2" >> config.txt

# make a backup in case we need to redo the command
if [ ! -f ./cmdline.txt.original ]
then
  cp -p cmdline.txt cmdline.txt.original
fi
# wipe out any previous changes
cp -p cmdline.txt.original cmdline.txt
# add the following to the end of the last (and only) line
sed '$s/$/ modules-load=dwc2,g_ether/' cmdline.txt.original > cmdline.txt


# go back to where we were
popd
