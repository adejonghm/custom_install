#!/bin/bash

##
##	Created by Alejandro de Jongh
##
##  Script to install all packages and configure the system in an automated way.
##	It is based on Ubuntu 20.04 with XFCE as the desktop environment.
##
##	Contact:
##		e-mail: dejongh.cu@gmail.com
##		telegram: https://t.me/adejonghm
##
##
##	Before running this script, check the latest versions of PHP and Python 
##	available in the official repositories to set the PHP_V and PY_V variables,
##


# =============== LEGEND =============== #
#  libappindicator1 --> (esta biblioteca es para rambox)
#  flashplugin-installer --> (para instalar adobe-flashplayer) luego instalamos adobe-flashplugin
#  caca-utils --> text mode graphics utilities. This package contains utilities and demonstration programs for libcaca, the Colour AsCii Art library.
#  ffmpeg --> es para el ClipGrab
#  libc-ares2 libcrypto++9v5 --> bibliotecas para MEGASync
#  matlab-support --> libreria para crear los symbolic links de MatLab. Se instalan despues de instalar MatLab.
#  sox --> comando para saber los metadatos de achivos de audio. Usar comando: soxi achivo.wav
#  exiftool --> comando para ver propiedades de las imagenes
#  xournal --> para resaltar texto PDF, poner firma (foto.png), etc....
#  firefox-globalmenu --> biblioteca para que funcione el globalmenu en firefox
#  coreutils --> library used by the new CP and MV command.
#  nvim: ctags, clangd-10, silversearcher-ag, ripgrep, fzf, ncdu, luarocks


PHP_V=7.4					# PHP version in official repositories.
PY_V=3.8					# Pyhton version in official repositories.


if [ "$UID" -ne "0" ]
then
 	echo "This script must be run as root."
 	exit 1
else
	# ========= REMOVE OLD APPS ========= #
	apt purge -y mousepad atril libreoffice-{base-core,calc,common,core,draw,gnome,gtk3,help-common,help-en-gb,help-en-us,impress,l10n-en-gb,l10n-en-za,math,style-colibre,style-elementary,style-tango,writer}


	# ========= CLEANNIG STUFF ========= #
	apt autoremove && sudo apt autoclean


	# ========= UPGRADE SYSTEM ========= #
	apt upgrade -y


	# ========= INSTALL SECTION ========= #
	##### Install system tools
	apt install -y cmake gcc g++ rar unrar unrar-free unace unace-nonfree zip unzip p7zip-full p7zip-rar bzip2 lzop gzip lzip samba htop neofetch ssh tree mc apache2 ffmpeg git sox exiftool httrack httrack-doc img2pdf

	##### Install network tools
	apt install -y netcat iptraf traceroute net-tools nmap ntp ntpdate curl

	##### Install some libraries
	apt install -y libjson-glib-dev libglib2.0-dev libpurple-dev libc-ares2 browser-plugin-freshplayer-pepperflash firefox-globalmenu

	##### Install App
	apt install -y atool caca-utils poppler-utils mediainfo highlight simplescreenrecorder w3m kid3 hardinfo pinta tilix xournal calibre neovim ranger sqlite3 sqlite3-doc sqlitebrowser qbittorrent blueman audacity gparted gthumb vlc mpv audacious evince ctags clangd-10 silversearcher-ag ripgrep fzf ncdu luarocks gedit gedit-plugin-text-size #vim vim-{addon-manager,youcompleteme,airline,airline-themes,syntax-gtk doc} remmina remmina-plugin-rdp
	
	##### Install Zshell
	apt install -y acpi autojump zsh zsh-doc

	##### Install Dev-Tools and Apps
	apt install -y libapache2-mod-php php$PHP_V php$PHP_V-{cli,sqlite,pgsql,gd} python$PY_V-dev python3-{pip,doc} nodejs npm ruby

	##### Install LaTeX
	apt install -y texstudio texlive lmodern texlive-{base,formats-extra,pictures,pictures-doc,bibtex-extra,publishers,publishers-doc,science,science-doc,lang-{spanish,english,portuguese,other},font-{utils,extra,extra-doc,recommended,recommended-doc} generic-{recommended,extra}}

	##### Install Eye-Candy
	apt install -y faenza-icon-theme breeze-cursor-theme #papirus-icon-theme elementary-icon-theme

	##### Install XFCE libraries & Apps
	apt install -y xfce4-clipman xfce4-clipman-plugin xfce4-appmenu-plugin

	##### Install Flatpak Apps
	flatpak install flathub org.gimp.GIMP com.spotify.Client #org.kiwix.desktop


	# ========= ADDING PPAs ========= #
	##### Add Albert Launcher
	sh -c 'echo "deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$(lsb_release -rs)/ /" > /etc/apt/sources.list.d/albert-launcher-$(lsb_release -cs).list'
	wget --quiet -O - https://build.opensuse.org/projects/home:manuelschneid3r/public_key.pub | apt-key add -

	##### Add Brave-Browser
	sh -c 'echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com stable main" > /etc/apt/sources.list.d/brave-browser-stable.list'
	wget --quiet -O - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key add -
	
	##### Add MegaSync
	sh -c 'echo "deb https://mega.nz/linux/MEGAsync/xUbuntu_$(lsb_release -rs)/ ./" > /etc/apt/sources.list.d/megasync.list'
	wget --quiet -O - https://mega.nz/linux/MEGAsync/xUbuntu_$(lsb_release -rs)/Release.key | apt-key add -
	
	##### Add Opera
	# sh -c 'echo "deb https://deb.opera.com/opera-stable/ stable non-free" > /etc/apt/sources.list.d/opera-browser-stable.list'
	# wget -q -O - https://deb.opera.com/archive.key | apt-key add -

	##### Add Postgresql
	#sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/postgresql-ubuntu-$(lsb_release -cs).list'
	#wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

	##### Add Skype for Linux
	sh -c 'echo "deb https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype-stable.list'
	wget --quiet -O - https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
	
	##### Add Spotify
	# sh -c 'echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify-stable.list'
	# curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -

	##### Add VSCode-Microsoft
	sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	wget --quiet -O - http://packages.microsoft.com/keys/microsoft.asc | apt-key add -

	##### Add VSCodium
	# sh -c 'echo "deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/" > /etc/apt/sources.list.d/vscodium.list'
	# wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg
	
	##### Add Clipgrab
	add-apt-repository -y ppa:clipgrab-team/ppa
	
	##### Add Fish
	# add-apt-repository -y ppa:fish-shell/release-3
			
	##### Add Handbrake
	add-apt-repository -y ppa:stebbins/handbrake-releases
	
	##### Add LibreOffice 7
	add-apt-repository -y ppa:libreoffice/libreoffice-7-0


	# ========= INSTALL FROM PPA ========= #
	apt install -y albert brave-browser clipgrab code handbrake-cli handbrake-gtk libreoffice megasync skypeforlinux zeal #opera-stable fish google-chrome-stable postgresql postgresql-client pgadmin4 spotify-client codium

fi


##* install Python OpenCV from repositories *##
 # sudo apt install python3-opencv libopencv-dev
 # python3 extract_frames.py
