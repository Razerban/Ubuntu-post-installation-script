#!/bin/zsh

######################################################################
# Written to be used on 64 bits computers with fresh setup of Ubuntu #
# Author    :   Ahmed Abdelkafi                                      #
######################################################################
#                                                                    #
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.       #
#                                                                    #
######################################################################

echo "1. Downloading Popcorn-Time"
cd /tmp
wget $(curl -Ls https://popcorntime.sh/fr | grep -Po '(?<=href=")[^"]*Linux-64.[^"]*(?=")' | head -1) -O popcorntime

echo "2. Install Popcorn-Time"
mkdir Popcorn-Time
tar -xf popcorntime -C ./Popcorn-Time
sudo mv Popcorn-Time /opt

echo "3. Create Launcher for Popcorn-Time"
sudo sh -c "cat <<EOL >>/usr/share/applications/Popcorn-Time.desktop
[Desktop Entry]
Comment=Watch movies in streaming with P2P.
Comment[fr]=Regarder des films en streaming.
Name=Popcorn Time
Exec=/opt/Popcorn-Time/Popcorn-Time
StartupNotify=false
Type=Application
Icon=/opt/Popcorn-Time/src/app/images/popcorntime.ico
EOL"
