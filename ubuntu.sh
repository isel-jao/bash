#!/bin/bash

#
# this is my custume settings for ubuntu 20.04 lts #######################################
#


BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m'

# printf "${YELLOW}Installin \n${NC}"
# printf "${GREEN}Success\n${NC}"
# printf "${RED}Failed\n${NC}"

#theme color
TC=red

HOME=/home/$(ls /home)
printf "${CYAN}USER\t${USER}\n${NC}" 
printf "${CYAN}HOME\t${HOME}\n${NC}" 

if [[ $USER != "root" ]]
then
	printf "${PURPLE}please run script in user mode \n${NC}" \
	&& exit 1
fi
printf "${PURPLE}press Ctrl-C to cancel scpript\n" 
I=3
while (( I > 0))
do
printf "\b%d" $I  && ((I--)) && sleep 1
done

clear

STEP=2
#first of all ######################################################################
if [[ $STEP -eq 0 ]]
then
	printf "${YELLOW}update and upgrade \n${NC}" 
	apt-get update &>/dev/null \
	&& apt-get upgrade -y &>/dev/null \
	&& printf "${GREEN}Success\n${NC}" && sed -i '0,/STEP=0/ s/STEP=0/STEP=1/' \
	./ubuntu.sh \
	|| printf "${RED}Failed\n${NC}"
fi

if [[ $STEP -lt 2 ]]
then
	printf "${YELLOW}Installing git curl wget gcc g++ clang make zsh gettext\n${NC}" 
	sudo apt install git curl wget gcc g++ clang make zsh gettext -y &>/dev/null\
	&& printf "${GREEN}Success\n${NC}" && sed -i '0,/STEP=1/ s/STEP=1/STEP=2/' \
	./ubuntu.sh\
	|| printf "${RED}Failed\n${NC}"
fi

# installing ohmyzsh ################################################################
printf "${YELLOW}Installing ohmyzsh\n${NC}" 
if test -e /root/.oh-my-zsh 
then
	printf "${GREEN}ohmyzsh already installed\n${NC}"
else
	wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh &>/dev/null\
	&& echo y | bash ./install.sh \
	&& printf "${GREEN}Success\n${NC}" \
	|| printf "${RED}Failed\n${NC}"
fi
rm -rf install.sh &>/dev/null\


EXTFOLDER=${HOME}/.local/share/gnome-shell/extensions

# themes and extantions ##################################################################
t=0
for arg in $@
do
	test $arg = '-t' -o $arg = '-a' && t=1 && break
done
test $t -eq 0 && exit 0

printf "${YELLOW}Installing gnome-tweak-tool\n${NC}"
mkdir  -p "${HOME}/.themes" "${HOME}/.icons" "${HOME}/.themes" "${HOME}/tmp"
apt install gnome-tweak-tool &>/dev/null \
&& printf "${GREEN}Success\n${NC}" \
|| (printf "${RED}gnome-tweak-tool not installed\n${NC}" \
&& sleep 1 && exit 1)



# orchis theme
printf "${YELLOW}Installing Orchis theme\n${NC}"
cd ${HOME}/tmp
if test -e ${HOME}/.themes/Orchis
then
	printf "${GREEN}Orchis theme already installed\n${NC}"
else
	git clone https://github.com/vinceliuice/Orchis-theme.git &>/dev/null \
	&& ./Orchis-theme/install.sh -d ${HOME}/.themes -t all &>/dev/null \
	&& gsettings set org.gnome.desktop.interface gtk-theme "Orchis-${TC}-dark-compact" \
	&& printf "${GREEN}Success\n${NC}" \
	|| printf "${RED}Failed\n${NC}"
fi

## tella icons
printf "${YELLOW}Installing Tela icons\n${NC}"
cd ${HOME}/tmp
if test -e ${HOME}/.icons/Tela-blue 
then
	printf "${GREEN}Tela icons already installed\n${NC}"
else
	git clone https://github.com/vinceliuice/Tela-icon-theme.git &>/dev/null \
	&& ./Tela-icon-theme/install.sh -a -d -d ${HOME}/.themes &>/dev/null \
	gsettings set org.gnome.desktop.interface icon-theme "Tela-${TC}" &>/dev/null\
	&& printf "${GREEN}Success\n${NC}" \
	|| printf "${RED}Failed\n${NC}"
fi


#dash to panel
cd ${HOME}/tmp
printf "${YELLOW}Installing dash-to-panel extention\n${NC}"
if test -e ${EXTFOLDER}/dash-to-panel@jderose9.github.com
then
	printf "${GREEN}dash-to-panel extantion already installed\n${NC}"
else 
	git clone https://github.com/home-sweet-gnome/dash-to-panel.git &>/dev/null \
	&& cd ./dash-to-panel/ \
	&& make install \
	&& gnome-extensions enable "dash-to-panel@jderose9.github.com" &>/dev/null \
	&& printf "${GREEN}Success\n${NC}" \
	|| printf "${RED}Failed\n${NC}"
fi

#night-light-toggle
printf "${YELLOW}Installing toggle-night-light extantion\n${NC}"
if test -e ${EXTFOLDER}/toggle-night-light@cansozbir.github.io
then
	printf "${GREEN}night-light-toggle extention already installed\n${NC}"
else 
	git clone https://github.com/cansozbir/gnome-shell-toggle-night-light-extension && \
	cd gnome-shell-toggle-night-light-extension/ && \
	cp -r toggle-night-light@cansozbir.github.io/ ~/.local/share/gnome-shell/extensions/ \
	&& gnome-extensions enable "toggle-night-light@cansozbir.github.io" &>/dev/null \
	&& printf "${GREEN}Success\n${NC}" \
	|| printf "${RED}Failed\n${NC}"
fi


# installing programes ###################################################################
p=0
for arg in $@
do
	test $arg = '-p' -o $arg = '-a' && p=1 && break
done
test $p -eq 0 && exit 0

printf "${YELLOW}Installing vscode\n${NC}"
which code  &>/dev/null \
&& printf "${GREEN}vscode already instlled\n${NC}" \
|| snap install code --classic 

printf "${YELLOW}Installing firefox\n${NC}"
which firefox  &>/dev/null \
&& printf "${GREEN}firefox already instlled\n${NC}" \
|| snap install firefox --classic 

printf "${YELLOW}Installing slack\n${NC}"
which slack  &>/dev/null \
&& printf "${GREEN}slack already instlled\n${NC}" \
|| snap install slack --classic 

printf "${YELLOW}Installing telegram-desktop \n${NC}"
which telegram-desktop  &>/dev/null \
&& printf "${GREEN}telegram-desktop  already instlled\n${NC}" \
|| snap install telegram-desktop  --classic 

printf "${YELLOW}Installing vlc \n${NC}"
which vlc  &>/dev/null \
&& printf "${GREEN}vlc  already instlled\n${NC}" \
|| snap install vlc  --classic 

printf "${YELLOW}Installing spotify \n${NC}"
which spotify  &>/dev/null \
&& printf "${GREEN}spotify  already instlled\n${NC}" \
|| snap install spotify  --classic 




#restart gnome #####################################################################
# printf "${YELLOW}Restarting gnome \n${NC}"
# sudo -u isel bash << EOF
# busctl --user call "org.gnome.Shell" "/org/gnome/Shell" "org.gnome.Shell" "Eval" "s" 'Meta.restart("Restarting…")';
# EOF
