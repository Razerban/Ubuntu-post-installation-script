#!/bin/bash

######################################################################
# Written to be used on 64 bits computers with fresh setup of Ubuntu #
# Author    :   Ahmed Abdelkafi                                      #
######################################################################
#                                                                    #
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.       #
#                                                                    #
######################################################################

echo '0. Configuring editors and copying files'
# Configure VIM and NANO
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
echo "syntax on" >> ~/.vimrc
# Configuring the Z shell
cp zshrc ~/.zshrc.bak
# Configure Sublime Text 3
mkdir -p ~/.config/sublime-text-3/Installed\ Packages/
wget https://packagecontrol.io/Package%20Control.sublime-package -O ~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
cp Package\ Control.sublime-settings ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
mkdir -p ~/.config/sublime-text-3/Packages/User
cp Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
echo '1. Adding repositories'
# Entering the tmp directory
cd /tmp
# Arc Theme GTK
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
sudo apt-key add - < Release.key
# Adapta Theme GTK
sudo apt-add-repository ppa:tista/adapta -y
# Ubuntu make
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y
# Indicator sound switcher
sudo apt-add-repository ppa:yktooo/ppa -y
# Indicator Netspeed
sudo apt-add-repository ppa:fixnix/netspeed -y
# Systemback
sudo add-apt-repository ppa:nemh/systemback -y
# Grub customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y
# Appgrid
sudo add-apt-repository -y ppa:appgrid/stable -y
# Canonical Partners
sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
# Graphics Drivers
# sudo add-apt-repository ppa:graphics-drivers/ppa -y
# Oracle JDK 7
sudo add-apt-repository ppa:webupd8team/java -y
# Indicator Brightness
sudo add-apt-repository ppa:indicator-brightness/ppa -y
# Brightness controller
sudo add-apt-repository ppa:apandada1/brightness-controller -y
# Prime Indicator Plus
sudo add-apt-repository ppa:nilarimogard/webupd8 -y
# Google Chrome
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo '2. Updating the system packages and installing packages and softwares from repositories'
# Remove gedit
sudo apt remove gedit libreoffice* unclutter -y
# Updating the apt cache
sudo apt update
# Installing system upgrades first
sudo apt upgrade -y
# Installing the packages and softwares from repos
sudo apt install google-chrome-stable prime-indicator-plus indicator-cpufreq unity-tweak-tool brightness-controller indicator-brightness ubuntu-restricted-extras unity-tweak-tool compizconfig-settings-manager arc-theme gnome-themes-* shimmer-themes adapta-gtk-theme curl wget ubuntu-make vlc gparted gksu clipit aptitude synaptic gdebi-core handbrake filezilla synaptic browser-plugin-vlc playonlinux aria2 qbittorrent tree inkscape clementine chromium-codecs-ffmpeg-extra pepperflashplugin-nonfree gdebi gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 shutter  flashplugin-installer gufw bleachbit youtube-dl python-software-properties openssh-server indicator-multiload caffeine variety indicator-sound-switcher indicator-netspeed-unity ffmpeg gxine htop libdvdread4 icedax tagtool libdvd-pkg easytag id3tool lame libxine2-ffmpeg nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra gstreamer1.0-libav p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller redshift redshift-gtk compiz compizconfig-settings-manager fonts-ancient-scripts ttf-ancient-fonts compiz-plugins systemback ubuntu-wallpapers-* ubuntukylin-wallpapers-* ubuntustudio-wallpapers git git-gui zsh build-essential curl python-setuptools ruby gcc libjpeg62:i386 libxtst6:i386 grub-customizer appgrid vim libxss1 git gitk gitg gparted linux-headers-generic dconf-tools rsync ssh openssh-server software-properties-common whiptail autotools-dev git-core samba winbind oracle-java7-installer oracle-java7-set-default -y
sudo apt install -f -y

echo '3. Installing softwares from official websites'
# Papirus icon theme
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh
# Install Oh-my-zsh framework
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -rf ~/.zshrc
mv ~/.zshrc.bak ~/.zshrc
# Install Linuxbrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
# Install Virtualbox and Virtualbox extension pack
wget $(curl -Ls https://www.virtualbox.org/wiki/Linux_Downloads | grep -Po '(?<=href=")[^"]*'$(lsb_release -sc)'_amd64.deb') -O vbox.deb
sudo dpkg -i vbox.deb
wget $(curl -Ls https://www.virtualbox.org/wiki/Downloads | grep -Po '(?<=href=")[^"]*.vbox-extpack' | grep "$(curl -Ls https://www.virtualbox.org/wiki/Linux_Downloads | grep -Po '(?<=href=")[^"]*'$(lsb_release -sc)'_amd64.deb' | grep -Po '(?<=-)[0-9]*(?=~)')")
VBoxManage extpack install Oracle_VM_VirtualBox*.vbox-extpack
# Installing Anaconda 2 & 3
wget $(curl -Ls https://www.continuum.io/downloads | grep -Po '(?<=href=")[^"]*Anaconda2[^"]*.Linux-x86_64.sh')
wget $(curl -Ls https://www.continuum.io/downloads | grep -Po '(?<=href=")[^"]*Anaconda3[^"]*.Linux-x86_64.sh')
bash Anaconda2*.sh -b -p $HOME/.anaconda/2
bash Anaconda3*.sh -b -p $HOME/.anaconda/3
# Installing Sublime text 3
wget $(curl -Ls http://www.sublimetext.com/3 | grep -Po '(?<=href=")[^"]*(?=">Ubuntu 64)') -O sublime-text.deb
sudo dpkg -i sublime-text.deb
# Installing Atom
wget https://atom.io/download/deb -O atom-installer.deb
sudo dpkg -i atom-installer.deb
# Installing Teamviewer
wget https://download.teamviewer.com/download/teamviewer_i386.deb
sudo dpkg -i teamviewer_i386.deb
# Installing Powerline fonts
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
# Installing Microsoft fonts
wget http://ftp.fr.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
sudo dpkg -i ttf-mscorefonts-installer_3.6_all.deb
# Installing NodeJS and NPM
wget $(curl -Ls https://nodejs.org/en/download/current/ | grep -Po '(?<=href=")[^"]*(?=">[^"]*.tar.gz)') -O node.tar.gz
tar -xvzf node.tar.gz
cd node
./configure
make -j$(nproc)
sudo make install
# Installing RubyGems
cd ..
git clone https://github.com/rubygems/rubygems
cd rubygems
sudo ruby setup.rb

echo '4. Configuring installed packages and softwares and tweaking the system'
# Show the username on the top menu bar
gsettings set com.canonical.indicator.session show-real-name-on-panel true
# Enable minimize on click
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
# Adding some effect to the minimize action of windows
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
# Configure the dash opening
gsettings set com.canonical.Unity form-factor 'Automatic'
# Configure the desktop launchers
gsettings set com.canonical.Unity.Launcher favorites "['application://ubiquity.desktop', 'application://org.gnome.Nautilus.desktop', 'application://sublime-text.desktop', 'application://firefox.desktop', 'application://org.gnome.Software.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
# Disable the online search in dash
gsettings set com.canonical.Unity.Lenses remote-content-search 'none'
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
# Disable the 'Recent files' feature
gsettings set org.gnome.desktop.privacy remember-recent-files false
# Disable guest session from login screen
sudo sh -c "echo 'allow-guest=false' >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf"
# Apply theme to the ubuntu interface
gsettings set org.gnome.desktop.interface gtk-theme "Adapta"
# Apply icon theme to ubuntu
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-dark'
# Configure git"
git config --global user.name "abdelkafiahmed"
git config --global user.email "abdelkafiahmed@yahoo.fr"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
# Set ZSH as the default shell
sudo chsh -s $(which zsh)
# Add the DNS servers of Google
sudo sh -c "echo 'nameserver 8.8.8.8' >> /etc/resolv.conf"
sudo sh -c "echo 'nameserver 8.8.4.4' >> /etc/resolv.conf"
# Disable ipv6 support
sudo sh -c "echo 'net.ipv6.conf.all.disable_ipv6=1' >> /etc/sysctl.conf"
sudo sh -c "echo 'net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf"
sudo sh -c "echo 'net.ipv6.conf.lo.disable_ipv6=1' >> /etc/sysctl.conf"
# Update AppStream
sudo appstreamcli refresh --force
# Cleanup
sudo apt -f install -y
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean
# Removing folders
rm -rf ~/Documents
rm -rf ~/Public
rm -rf ~/Templates
rm -rf ~/Images # Support for french version
rm -rf ~/Pictures
rm -rf ~/Modèles # Support for french version
rm -rf ~/Videos
rm -rf ~/Vidéos # Support for french version
rm -rf ~/Music
rm -rf ~/Musique # Support for french version
rm ~/examples.desktop
mkdir ~/Development
# Remove folders from the nautilus sidebar
sed -i.bak '/XDG_TEMPLATES_DIR\|XDG_PUBLICSHARE_DIR\|XDG_DOCUMENTS_DIR\|XDG_MUSIC_DIR\|XDG_PICTURES_DIR\|XDG_VIDEOS_DIR/d' ~/.config/user-dirs.dirs
echo "enabled=false" > ~/.config/user-dirs.conf # To make the change permanent
# Add programs to start when user logs in
mkdir -p ~/.config/autostart
sudo touch /usr/share/applications/indicator-cpufreq.desktop
sudo sh -c "cat <<EOL >>/usr/share/applications/indicator-cpufreq.desktop
[Desktop Entry]
Name=CPU Frequency Indicator
Exec=indicator-cpufreq
Terminal=false
Type=Application
Icon=utilities-system-monitor
Categories=GNOME;System;
EOL"
sudo sh -c "cat <<EOL >>/usr/share/applications/prime-indicator.desktop
[Desktop Entry]
Name=Prime Indicator Plus
Exec=prime-indicator
Terminal=false
Type=Application
Icon=nvidia-settings
Categories=GNOME;System;Settings;
EOL"
cp /usr/share/applications/indicator-cpufreq.desktop ~/.config/autostart
cp /usr/share/applications/indicator-multiload.desktop ~/.config/autostart
cp /usr/share/applications/redshift-gtk.desktop ~/.config/autostart
cp /usr/share/applications/indicator-netspeed-unity.desktop ~/.config/autostart
cp /usr/share/applications/indicator-sound-switcher.desktop ~/.config/autostart
cp /usr/share/applications/caffeine-indicator.desktop ~/.config/autostart
cp /usr/share/applications/prime-indicator.desktop ~/.config/autostart
# Make Ubuntu use 'Local' time instead of Hardware time
sudo timedatectl set-local-rtc 1
timedatectl set-local-rtc 1
# Prompt for a reboot
clear
echo ""
echo "===================="
echo " TIME FOR A REBOOT! "
echo "===================="
echo ""
