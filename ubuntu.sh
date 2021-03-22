#!/bin/bash

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

I=3

HOME=/home/$(ls /home)
printf "${CYAN}USER\t${USER}\n${NC}" 
printf "${CYAN}HOME\t${HOME}\n${NC}" 

if [[ $USER != "root" ]]
then
    printf "${PURPLE}please run script in user mode \n${NC}" \
    && exit 1
fi
printf "${PURPLE}press Ctrl-C to cancel scpript\n" 
while (( I > 0))
do
printf "\b%d" $I  && ((I--)) && sleep 1
done

clear


# read "inster user"

#first of all ######################################################################
printf "${YELLOW}update and upgrade \n${NC}" 
apt-get update &>/dev/null \
&& apt-get upgrade -y &>/dev/null \
&& printf "${GREEN}Success\n${NC}" \
|| printf "${RED}Failed\n${NC}"

printf "${YELLOW}Installing git curl wget gcc g++ clang make zsh gettext\n${NC}" 
sudo apt install git curl wget gcc g++ clang make zsh gettext -y &>/dev/null\
&& printf "${GREEN}Success\n${NC}" \
|| printf "${RED}Failed\n${NC}"

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



# themes and extantions ########################################################
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
printf "${YELLOW}Installing dash-to-panel extantion\n${NC}"
git clone https://github.com/home-sweet-gnome/dash-to-panel.git &>/dev/null \
&& cd ./dash-to-panel/ \
&& make install \
&& gnome-extensions enable "dash-to-panel@jderose9.github.com" &>/dev/null \
&& printf "${GREEN}Success\n${NC}" \
|| printf "${RED}Failed\n${NC}"

# installing programes ###################################################################
printf "${YELLOW}Installing vscode\n${NC}"
code -v &>/dev/null \
&& printf "${RED}vscode already instlled\n${NC}" \
|| snap install code --classic \

printf "${YELLOW}Installing slack\n${NC}"
snap install slack --classic



# restart gnome #####################################################################
# printf "${YELLOW}Restarting gnome \n${NC}"
# sudo -u isel bash << EOF
# busctl --user call "org.gnome.Shell" "/org/gnome/Shell" "org.gnome.Shell" "Eval" "s" 'Meta.restart("Restarting…")';
# whoami
# EOF
