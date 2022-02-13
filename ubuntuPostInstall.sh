#!/bin/bash

# include all code in function.sh script
source function.sh

# ask for root access
[ "$(whoami)" != "root" ] && exec sudo bash -- "$0" "$@"


programs=
# apt-get
programs+=" git"
programs+=" curl"
programs+=" wget"
programs+=" make"
programs+=" zsh"
programs+=" gcc"
programs+=" g++"
programs+=" clang"
programs+=" gnome-tweaks"
programs+=" blueman"
programs+=" fonts-powerline"
programs+=" telegram-desktop"
programs+=" google-chrome-stable"
programs+=" npm"
programs+=" teamviewer"
# snap
programs+=" discord"
programs+=" spotify"
programs+=" vlc"
programs+=" code"


# update repos
function update()
{
	echo -n -e "${Blue}update ..."
	apt-get update &>/dev/null
	test $? -eq 0 &&  echo  -e "\r${Green}update ✅ ${White} " || echo  -e "\r${Red}update ❌ "  
}


# install updates
function upgrade()
{
	echo -n -e "${Blue}upgrade ..."
	apt-get upgrade -y  &>/dev/null
	test $? -eq 0 &&  echo  -e "\r${Green}upgrade ✅ ${White} " || echo  -e "\r${Red}upgrade ❌ " 
}


function install()
{
	test $# -lt 1 && echo -e "${Red}Error: install function require one or more arguments."  && return

	programs=($@)
	index=0

	while [ $index -lt $# ]
	do
		program=${programs[$index]}

		echo -n -e "${Blue}${program} ..."

		which $program &>/dev/null || apt install $program -y &>/dev/null \
		|| snap install $program --classic  &>/dev/null

		test $? -eq 0 &&  echo  -e "\r${Green}$program ✅ ${White}" || echo  -e "\r${Red}$program ❌ ${White}"

		((index++))
	done
}


function install_themes()
{
	ICONS_DIR="/usr/share/.icons"
	THEMES_DIR="/usr/share/.icons"

	mkdir ${ICONS_DIR} &>/dev/null
	mkdir ${THEMES_DIR} &>/dev/null

	# install papirus icons
	wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="${ICONS_DIR}/.icons" sh

}


update && upgrade || exit

install  ${programs} # defined above

[[ $1 == "-t" ]] && install_themes


