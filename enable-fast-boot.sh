#!/bin/bash -e

echo -n "Do you want to enable fast boot? [y/N]"
read REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

echo -e "\n# Disable the rainbow splash screen
disable_splash=1
\n# Set bootloader delay to 0 seconds (Default is 1 second)
boot_delay=0
initial_turbo=20
#dtoverlay=pi3-disable-wifi" >> /boot/config.txt
#Doing serial disable in raspi-config adds enable_uart=0, does this kill bt?

if ! grep -q 'quiet' /boot/cmdline.txt; then
    echo "Adding 'quiet' to /boot/cmdline.txt"
    sudo sed  -i '/./s/$/ quiet/' /boot/cmdline.txt
fi

sudo raspi-config nonint do_boot_wait 1 # Disable wait for network boot
# sudo raspi-config nonint do_serial 1

# ToDo: Make this a unified prompt like "Fastboot option: 1) Basic 2) Agressive [w/networking] 3) Agressive [w/o networking]
echo -n "Run agressive fastboot settings? [y/N]"
read REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

sudo systemctl disable keyboard-setup.service
sudo systemctl disable avahi-daemon.service
sudo systemctl disable triggerhappy.service
sudo systemctl disable systemd-timesyncd.service
sudo apt-get install busybox-syslogd; sudo dpkg --purge rsyslog
sudo systemctl disable dphys-swapfile.service
sudo systemctl disable apt-daily.service
sudo systemctl disable raspi-config.service
sudo systemctl disable networking.service
sudo systemctl disable ssh.service
sudo systemctl disable dhcpcd.service
sudo systemctl disable wpa_supplicant.service
sudo systemctl disable rng-tools.service
#sudo systemctl disable hciuart.service # WARNING: This one disables bluetooth!!