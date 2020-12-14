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
##	Before running this script, check the latest version of Telegram Desktop, Coreutils,
##  PHP and Python (available in the official repositories) to set the TDESKTOP_VERSION, 
##  CUTILS_VERSION, PHP_V and PY_V variables.
##


###### Setting variables
export TDESKTOP_VERSION=2.4.7			# Telegram Desktop version https://desktop.telegram.org/
export CUTILS_VERSION=8.32				# coreutils version https://ftp.gnu.org/gnu/coreutils/?C=M;O=D
export PHP_V=7.4                        # PHP version in official repositories.
export PY_V=3.8                         # Pyhton version in official repositories.

###### Copying files into the HOME directory
cp -v .conkyrc .vimrc .zshrc .p10k.zsh $HOME/
cp -v templates/bash_template.sh templates/latex_cover_template.tex templates/python_template.py $HOME/Templates/


###### OS Installation
sudo bash scripts/os_install.sh


###### Python Installation
pip3 install --user wheel pylint pylama uncompyle6 isort fuzzywuzzy requests cookiecutter pulsectl tzlocal pycountry bs4 overrides colour lxml pipenv pynvim neovim-remote autopep8


###### Ruby Installation
gem install neovim solargraph


###### Node Installation
npm i -g bash-language-server neovim flow-language-server

###### Configurations
bash scripts/config.sh


###### Delete all
rm -Rf $(pwd)











