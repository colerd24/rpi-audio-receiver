#!/bin/bash -e

echo -n "Do you want to enable fast boot? [y/N]"
read REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

cat <<'EOF' > /boot/config.txt
 # Disable the rainbow splash screen
disable_splash=1

# Set bootloader delay to 0 seconds (Default is 1 second)
boot_delay=0
EOF

if ! grep -q 'quiet' /boot/cmdline.txt; then
    echo "Adding 'quiet' to /boot/cmdline.txt"
    sudo sed  -i '/./s/$/ quiet/' /boot/cmdline.txt
fi

