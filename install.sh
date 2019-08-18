#!/bin/bash -e

echo "Updating packages"
sudo apt update
sudo apt upgrade -y

echo "Installing components"
sudo ./update-hostname.sh
#sudo ./update-password.sh
sudo ./install-bluetooth.sh
#sudo ./install-shairport.sh
#sudo ./install-spotify.sh
#sudo ./install-upnp.sh
#sudo ./install-snapcast-client.sh
sudo ./install-startup-sound.sh
#sudo ./install-pivumeter.sh
#sudo ./enable-hifiberry.sh
#sudo ./install-aplay-zero.sh
sudo ./enable-fast-boot.sh
sudo ./enable-read-only.sh
