#!/bin/bash

#!/bin/bash


# Text Colour
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Magenta='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

# Background Colour
bg_Black='\033[0;40m'
bg_Red='\033[0;41m'
bg_Green='\033[0;42m'
bg_Yellow='\033[0;43m'
bg_Blue='\033[0;44m'
bg_Magenta='\033[0;45m'
bg_Cyan='\033[0;46m'
bg_White='\033[0;47m'

# Text Formatting
Regular='\033[0;31m'
Bold='\033[1;31m'
Low_Intensity='\033[2;31m'
Italic='\033[3;31m'
Underline='\033[4;31m'
Blinking='\033[5;31m'
Reverse='\033[6;31m'
Background='\033[7;31m'
Invisible='\033[8;31m'

#   ___  ____  ____  ____  _  _  ___    __  __    __    _  _  ____  ____  __  __  __      __   ____  ____  _____  _  _   
#  / __)(_  _)(  _ \(_  _)( \( )/ __)  (  \/  )  /__\  ( \( )(_  _)(  _ \(  )(  )(  )    /__\ (_  _)(_  _)(  _  )( \( )  
#  \__ \  )(   )   / _)(_  )  (( (_-.   )    (  /(__)\  )  (  _)(_  )___/ )(__)(  )(__  /(__)\  )(   _)(_  )(_)(  )  (   
#  (___/ (__) (_)\_)(____)(_)\_)\___/  (_/\/\_)(__)(__)(_)\_)(____)(__)  (______)(____)(__)(__)(__) (____)(_____)(_)\_)  

function to_upper()
{
	for str in $@
	do
		echo -n ${str^^} ''
	done
}

function capitalize()
{
	for str in $@
	do
		echo -n ${str^} ''
	done
}

function to_lower()
{
	for str in $@
	do
		echo -n ${str,,} ''
	done
}


#   ____  ____  ____  __  __  ____  _  _    __    __      ____  _  _  ____  ____  ____  ____  _____  ___    __   ____  ____  _____  _  _ 
#  (_  _)( ___)(  _ \(  \/  )(_  _)( \( )  /__\  (  )    (_  _)( \( )(_  _)( ___)(  _ \(  _ \(  _  )/ __)  /__\ (_  _)(_  _)(  _  )( \( )
#    )(   )__)  )   / )    (  _)(_  )  (  /(__)\  )(__    _)(_  )  (   )(   )__)  )   / )   / )(_)(( (_-. /(__)\  )(   _)(_  )(_)(  )  ( 
#   (__) (____)(_)\_)(_/\/\_)(____)(_)\_)(__)(__)(____)  (____)(_)\_) (__) (____)(_)\_)(_)\_)(_____)\___/(__)(__)(__) (____)(_____)(_)\_)

# print numbers of columns in the current terminal
function get_terminal_width()
{
	tput cols
}

# print numbers of lines in the current terminal
function get_terminal_hight()
{
	tput lines
}

# git the cursor cordinants in the format cols;lines
function get_cursor_positions()
{
	echo -en "\E[6n"
	read -sdR CURPOS
	CURPOS=${CURPOS#*[}
	echo $CURPOS
}


#   _    _  ____  ____  ____  ____  _  _  ___    ____  __  __  _  _  ___  ____  ____  _____  _  _  ___ 
#  ( \/\/ )(  _ \(_  _)(_  _)(_  _)( \( )/ __)  ( ___)(  )(  )( \( )/ __)(_  _)(_  _)(  _  )( \( )/ __)
#   )    (  )   / _)(_   )(   _)(_  )  (( (_-.   )__)  )(__)(  )  (( (__   )(   _)(_  )(_)(  )  ( \__ \
#  (__/\__)(_)\_)(____) (__) (____)(_)\_)\___/  (__)  (______)(_)\_)\___) (__) (____)(_____)(_)\_)(___/

# void putnstr(char *s, int n) // print string n times
function putnstr()
{
	count=0
	test $# -eq 2 && \
	while test $count -lt $2
	do
		echo -n $1
		((count++))
	done
}


# void print_color(color, str1, str2, ...)
function print_color()
{
	arr=($@)
	color=$1
	color=${color,,}
	color=${color^}
	eval color=\$$color
	echo -n -e $color

	if test $# -gt 1  				# check if there is more than one arg
	then
		echo -e -n $color			# change printing color to the one passed in arg[1]
		echo -n ${arr[@]:1}			# print the array passed starting from index 1
		echo -e -n $White			# change printing color to white
	fi
}


function print_title()
{
	str=($@)
	str=${str[@]:1}							
	char=$1
	width=$(tput cols) 
	if test $# -ge 2 && test ${#char} -eq 1
	then
		putnstr $char $width
		echo 
		w=$(($width - ${#str} - 4))
		test $w -gt 0 && \
		putnstr $char $(( w / 2 ))
		echo -n  ' ' $str ' '
		test $w -gt 0 && \
		putnstr $char $(( w / 2 + w % 2))
		putnstr $char $width
		echo 
	fi
}