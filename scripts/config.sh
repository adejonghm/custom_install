#!/bin/bash

##
##	Created by Alejandro de Jongh
##
##  Ubuntu 18.04-based script with XFCE desktop environment to install  
##  and configure the necessary software and packages in an automated way.
##
##	Contact:
##		e-mail: dejongh.cu@gmail.com
##		telegram: https://t.me/adejonghm
##


##### Telegram Desktop
wget -qc https://updates.tdesktop.com/tlinux/tsetup.$TDESKTOP_VERSION.tar.xz
tar -xf tsetup.$TDESKTOP_VERSION.tar.xz
rm -f tsetup.$TDESKTOP_VERSION.tar.xz


##### XFCE Globla Menu
xfconf-query -c xsettings -p /Gtk/ShellShowsMenubar -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true


##### Advanced cp & mv command configuration (with progress-bar)
wget -qc http://ftp.gnu.org/gnu/coreutils/coreutils-$CUTILS_VERSION.tar.xz
tar -xJf coreutils-$CUTILS_VERSION.tar.xz
rm -f coreutils-$CUTILS_VERSION.tar.xz

cd coreutils-$CUTILS_VERSION/
wget -qc https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-$CUTILS_VERSION.patch
patch -p1 -i advcpmv-0.8-$CUTILS_VERSION.patch
./configure
make


##### Configure ZShell (Oh-My-Zsh)
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k (download fonts from github and copy to ~/.local/share/fonts/)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Configure fuzzy finder (Ubuntu 18.04) for Ubuntu 19.10+ use apt install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


##### Copying files
sudo -- sh -c 'mv -vf Telegram/ /opt/telegram-desktop/; ln -sf /opt/telegram-desktop/Telegram /usr/bin/telegram'

sudo -- sh -c 'cp -vf src/cp /usr/bin/cp; cp -vf src/mv /usr/bin/mv'
cd ../ && rm -rf coreutils-$CUTILS_VERSION/


##### Configure wakatime.cfg
touch ~/.wakatime.cfg
echo "[settings]
api_key = 
include = 
	$HOME/Github/master_code
	$HOME/Github/first_blog
	$HOME/Github/web_instec
include_only_with_project_file = true
status_bar_icon = true
status_bar_enabled = true
status_bar_coding_activity = true
offline = true
no_ssl_verify = false
hostname = $(hostname)
timeout = 15" > ~/.wakatime.cfg


##### Configure Smb
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bck
echo " 
#### FOLDER SHARED ####
[Download]
	path=/media/$USER/Depot/Downloads/
	writeable = yes
	browseable = yes
	read only = no
	force user = $USER
" >> /etc/samba/smb.conf