#!/bin/bash

######################################################################
# Written to be used on 64 bits computers with fresh setup of Ubuntu #
# Author    :   Ahmed Abdelkafi                                      #
######################################################################
#                                                                    #
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. AT YOUR OWN RISK.       #
#                                                                    #
######################################################################

echo "1. Checking for system updates"
sudo apt update
sudo apt upgrade -y

echo "2. Entering Temporary directory"
cd /tmp

echo "3. Installing Ubuntu Restricted Extras"
sudo apt install ubuntu-restricted-extras -y

echo "4. Adding some effect to the minimize action of windows"
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

echo "5. Setup of Tweak Tools"
sudo apt install unity-tweak-tool -y
sudo apt install compizconfig-settings-manager -y

echo "6. Setup of Themes"
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
sudo apt-key add - < Release.key
sudo apt update && sudo apt install arc-theme -y
sudo apt-add-repository ppa:tista/adapta -y
sudo apt update && sudo apt install gnome-themes-* shimmer-themes adapta-gtk-theme -y

echo "7. Install icon themes"
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install-papirus-home-gtk.sh | sh

echo "8. Install some useful softwares"
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y
sudo apt update
sudo apt install curl wget ubuntu-make vlc gparted gksu clipit aptitude synaptic gdebi-core handbrake filezilla synaptic browser-plugin-vlc playonlinux aria2 qbittorrent tree inkscape clementine chromium-codecs-ffmpeg-extra pepperflashplugin-nonfree gdebi skype gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 shutter dropbox flashplugin-installer gufw bleachbit youtube-dl python-software-properties openssh-server default-jdk virtualbox virtualbox-ext-pack -y

echo "9. Install some useful indicators"
sudo apt install indicator-multiload caffeine variety -y
sudo apt-add-repository ppa:yktooo/ppa -y
sudo apt update && sudo apt install indicator-sound-switcher -y
sudo apt-add-repository ppa:fixnix/netspeed -y
sudo apt update
sudo apt install indicator-netspeed-unity -y

echo "10. install multimedia codecs"
sudo apt install ffmpeg gxine htop libdvdread4 icedax tagtool libdvd-pkg easytag id3tool lame libxine2-ffmpeg nautilus-script-audio-convert libmad0 mpg321 libavcodec-extra gstreamer1.0-libav -y

echo "11. install compression tools"
sudo apt install p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller -y

echo "12. Disable guest session from login screen"
sudo sh -c "echo 'allow-guest=false' >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf"

echo "13. Install redshift"
sudo apt install redshift -y

echo "14. Show the username on the top menu bar"
gsettings set com.canonical.indicator.session show-real-name-on-panel true

echo "15. Install compiz and system back"
sudo add-apt-repository ppa:nemh/systemback -y
sudo apt update
sudo apt install compiz compizconfig-settings-manager compiz-plugins systemback -y

echo "16. Install all ubuntu wallpapers"
sudo apt install ubuntu-wallpapers-* ubuntukylin-wallpapers-* ubuntustudio-wallpapers -y

echo "17. Enable minimize on click"
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

echo "18. Install git and configure it"
# checking if git is installed else install it
if ! location="$(type -p "git")" || [ -z "git" ]; then
    sudo apt install git git-gui -y
fi

git config --global user.name "abdelkafiahmed"
git config --global user.email "abdelkafiahmed@yahoo.fr"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple

echo "19. Install ZSH and Oh-my-zsh"
sudo apt install zsh -y
sudo chsh -s /bin/zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp zshrc ~/.zshrc

echo "20. Install LinuxBrew"
sudo apt install build-essential curl git python-setuptools ruby gcc -y
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
echo "# Configure LinuxBrew" >> ~/.zshrc
echo 'export PATH=$HOME/.linuxbrew/bin:$PATH' >> ~/.zshrc
echo 'export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH' >> ~/.zshrc
echo 'export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH' >> ~/.zshrc
echo "# END Configure LinuxBrew" >> ~/.zshrc
echo '' >> ~/.zshrc

echo "21. Install VirtualBox"
wget $(curl -Ls https://www.virtualbox.org/wiki/Linux_Downloads | grep -Po '(?<=href=")[^"]*'$(lsb_release -sc)'_amd64.deb') -O vbox.deb
sudo dpkg -i vbox.deb
wget $(curl -Ls https://www.virtualbox.org/wiki/Downloads | grep -Po '(?<=href=")[^"]*.vbox-extpack' | grep "$(curl -Ls https://www.virtualbox.org/wiki/Linux_Downloads | grep -Po '(?<=href=")[^"]*'$(lsb_release -sc)'_amd64.deb' | grep -Po '(?<=-)[0-9]*(?=~)')")
VBoxManage extpack install Oracle_VM_VirtualBox*.vbox-extpack

echo "22. Install Anaconda 2 & 3"
wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh
wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
bash Anaconda2-4.2.0-Linux-x86_64.sh -b -p $HOME/.anaconda/2
bash Anaconda3-4.2.0-Linux-x86_64.sh -b -p $HOME/.anaconda/3

echo "# PYTHON VARIABLES START" >> ~/.zshrc
echo 'export ANACONDA2=$HOME/.anaconda/2' >> ~/.zshrc
echo 'export ANACONDA3=$HOME/.anaconda/3' >> ~/.zshrc
echo 'export PYTHONPATH=$ANACONDA2:$PYTHONPATH$' >> ~/.zshrc
echo 'export PYTHONUSERBASE=$ANACONDA2' >> ~/.zshrc
echo 'export PATH=$ANACONDA3/bin:$PATH' >> ~/.zshrc
echo 'export PATH=$ANACONDA2/bin:$PATH' >> ~/.zshrc
echo "# PYTHON VARIABLES END" >> ~/.zshrc
echo '' >> ~/.zshrc
echo "# PYTHON ALIASES START" >> ~/.zshrc
echo 'alias anaconda2_update="$ANACONDA2/bin/conda update --all -y"' >> ~/.zshrc
echo 'alias anaconda3_update="$ANACONDA3/bin/conda update --all -y"' >> ~/.zshrc
echo 'alias pip2="$ANACONDA2/bin/pip"' >> ~/.zshrc
echo 'alias pip3="$ANACONDA3/bin/pip"' >> ~/.zshrc
echo "# PYTHON ALIASES END" >> ~/.zshrc
echo '' >> ~/.zshrc

echo "23. Install Sublime Text 3 and Atom"
wget $(curl -Ls http://www.sublimetext.com/3 | grep -Po '(?<=href=")[^"]*(?=">Ubuntu 64)') -O sublime-text.deb
sudo dpkg -i sublime-text.deb
wget https://atom.io/download/deb -O atom-installer.deb
sudo dpkg -i atom-installer.deb

echo "24. Install Teamviewer"
sudo apt install libjpeg62:i386 libxtst6:i386
wget https://download.teamviewer.com/download/teamviewer_i386.deb
sudo dpkg -i teamviewer_i386.deb

echo "25. Install Grub Customizer"
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y
sudo apt update
sudo apt install grub-customizer -y

echo "26. Install appgrid"
sudo add-apt-repository -y ppa:appgrid/stable -y
sudo apt update
sudo apt install appgrid

echo "27. Add the DNS servers of Google"
sudo sh -c "echo 'nameserver 8.8.8.8' >> /etc/resolv.conf"
sudo sh -c "echo 'nameserver 8.8.4.4' >> /etc/resolv.conf"

echo "28. Install dependencies"
sudo apt install -f

echo "29. Install powerline fonts"
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

echo "30. Install Vivaldi browser"
sudo sh -c "echo 'deb http://repo.vivaldi.com/stable/deb/ stable main' >> /etc/apt/sources.list"
wget http://repo.vivaldi.com/stable/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
sudo apt update && sudo apt install vivaldi-stable -y

echo "32. Cleanup"
sudo apt -f install -y
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean

echo "33. Configure VIM and NANO"
sudo apt install vim -y
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
echo "syntax on" >> .vimrc

echo "34. Configure Sublime Text 3"
wget https://packagecontrol.io/Package%20Control.sublime-package -O ~/.config/sublime-text-3/Installed Packages/Package Control.sublime-package
cp Package Control.sublime-settings ~/.config/sublime-text-3/Packages/User/Package Control.sublime-settings
cp Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

echo "35. Update AppStream"
sudo apt install appstream/xenial-backports -y
sudo appstreamcli refresh --force

echo "36. Disable ipv6 support"
sudo sh -c "echo 'net.ipv6.conf.all.disable_ipv6=1' >> /etc/sysctl.conf"
sudo sh -c "echo 'net.ipv6.conf.default.disable_ipv6=1' >> /etc/sysctl.conf"
sudo sh -c "echo 'net.ipv6.conf.lo.disable_ipv6=1' >> /etc/sysctl.conf"

echo "TODO : Update the Shell with the new variables : source ~/.zshrc"
echo "TODO : Setup the theme and icom theme using Unity tweak tool"
echo "TODO : Apply licence for SublimeText 3"
echo "TODO : Install IntelliJ Idea"
