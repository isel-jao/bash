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

# void putnstr(char *string, int n) // print string n times
# example usage --> putnstr hello 3  
function putnstr()
{
	count=0
	re='^[0-9]+$'
	test $# -eq 2 && [[ $2 =~ $re ]] && \
	while test $count -lt $2
	do
		echo -n $1
		((count++))
	done
}

# example1 usage --> print_color red how Yellow are BLeU you
# example2 usage --> print_color red -i  blue blue -i red
function print_color()
{
	ignore=0
	index=0
	arr=($@)
	while [ $index -lt $# ]
	do
		arg=${arr[$index]}
		if [ $arg = '-i' ]; then
			ignore=1
			((index++))
			arg=${arr[$index]}
		fi
		color=$arg
		color=${color,,}
		color=${color^}
		color=${!color}
		if [ $ignore -eq 0 -a ${#color} -gt 0 ]; then
			echo -n -e $color
		else
			echo -n $arg ''
		fi
		ignore=0
		((index++))
	done
	echo
}

# example usage --> print_title '-' hallo world
function print_title()
{
	color1=${Blue}								# carachter color
	color2=${Magenta}							# text color
	str=($@)
	str=${str[@]:1}								# remove arg[1] from passed array		
	char=$1
	width=$(tput cols) 							# get terminal width
	if test $# -ge 2 && test ${#char} -eq 1		
	then
		echo -e -n $color1						# set printing color to color1
		putnstr $char $width					
		echo 
		w=$(($width - ${#str} - 4))
		test $w -gt 0 && \
		putnstr $char $(( w / 2 ))
		echo -e -n $color2						# set printing color to color2				
		echo -n  ' ' $str ' '
		echo -e -n $color1						# set printing color to color1
		test $w -gt 0 && \
		putnstr $char $(( w / 2 + w % 2))
		putnstr $char $width
		echo 
	fi
	echo -e -n $White							# set printing color to white
}


# // size_t strlen(char *s) // 
# print the length of the given bash variable. 
# example usage --> stlen hallo world
function strlen()
{
	str=$@
	echo ${#str}
}

#   ____  ____  ____  __  __ _   ___    _  _   __   __ _  __  ____  _  _  __     __  ____  __  __   __ _ 
#  / ___)(_  _)(  _ \(  )(  ( \ / __)  ( \/ ) / _\ (  ( \(  )(  _ \/ )( \(  )   / _\(_  _)(  )/  \ (  ( \
#  \___ \  )(   )   / )( /    /( (_ \  / \/ \/    \/    / )(  ) __/) \/ (/ (_/\/    \ )(   )((  O )/    /
#  (____/ (__) (__\_)(__)\_)__) \___/  \_)(_/\_/\_/\_)__)(__)(__)  \____/\____/\_/\_/(__) (__)\__/ \_)__)

# conver string to upercase
# example usage --> to_upper hallo world
function to_upper()
{
	for str in $@
	do
		echo -n ${str^^} ''
	done
}

# conver string to capitalize
# example usage --> to_upper hallo world
function capitalize()
{
	for str in $@
	do
		echo -n ${str^} ''
	done
}

# conver string to lowercase
# example usage --> to_upper hallo world
function to_lower()
{
	for str in $@
	do
		echo -n ${str,,} ''
	done
}

# // char *substr(char *s, int postion, int lenght)
# Extract substring from $string at $position (lenght not given)
# Extract maximum $length charactres from $string at $position (lenght is given)
# example1 usage --> substr CrazyWorld 2
# example1 usage --> substr CrazyWorld 2 4
function substr()
{
	string=$1
	positoin=$2
	length=$3
	echo -n ${string:positoin:length}
}

# +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+
# |S|u|b|s|t|r|i|n|g| |M|a|t|c|h|
# +-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+

# deletes the shortest match of $substring from front of $string
# example1 usage --> front_shortest $(pwd) /
function front_shortest()
{
	string=$1
	substring=*$2
	echo -n ${string#$substring}
}

# deletes the shortest match of $substring from back of $string
# example1 usage --> back_shortest $(pwd) /
function back_shortest()
{
	string=$1
	substring=$2*
	echo -n ${string%$substring}
}

# deletes the longest match of $substring from front of $string
# example1 usage --> front_longest $(pwd) /
function front_longest()
{
	string=$1
	substring=*$2
	echo -n ${string##$substring}
}

# deletes the longest match of $substring from back of $string
# example1 usage --> back_longest $(pwd) /
function back_longest()
{
	string=$1
	substring=$2*
	echo -n ${string%%$substring}
}

# +-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+-+-+-+
# |F|i|n|d| |a|n|d| |R|e|p|l|a|c|e| |S|t|r|i|n|g| |V|a|l|u|e|s|
# +-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+-+-+-+

# // char *replace_first( char *pattern, char *raplacement, char *str1, char *str2, ...)
# Replace only first match (works with wild card)
# example1 usage --> replace_first replace_first 'fuck' 'f*ck' fuck that fucking motherfucker 
function replace_first()
{
	arr=($@)
	pattern=$1
	replacement=$2
	test $# -gt 2 && \
	string=${arr[@]:2} && \
	echo -n ${string/$pattern/$replacement}
}

# // char *replace_all( char *pattern, char *raplacement, char *str1, char *str2, ...)
# Replace all the matches (works with wild card)
# example1 usage --> replace_all  'fuck' 'f*ck' fuck that fucking motherfucker 
function replace_all()
{
	arr=($@)
	pattern=$1
	replacement=$2
	test $# -gt 2 && \
	string=${arr[@]:2} && \
	echo -n ${string//$pattern/$replacement}
}


function is_unsigned()
{
	re='^[0-9]+$'
	if  [[ $1 =~ $re ]] ; then
		echo "is a number" >&2
	else
		echo "error: Not a number" >&2
	fi
}

arr=($@)
str=${arr[@]:1}

test $# -gt 0 && \
$1 $str || \
read -r -p "inter command" cmd && \
$cmd


#    __   _  _  __  ___  __ _    ____  ____  ____  ____  ____  ____  __ _   ___  ____  ____ 
#   /  \ / )( \(  )/ __)(  / )  (  _ \(  __)(  __)(  __)(  _ \(  __)(  ( \ / __)(  __)/ ___)
#  (  O )) \/ ( )(( (__  )  (    )   / ) _)  ) _)  ) _)  )   / ) _) /    /( (__  ) _) \___ \
#   \__\)\____/(__)\___)(__\_)  (__\_)(____)(__)  (____)(__\_)(____)\_)__) \___)(____)(____/

# Bash Brackets Quick Reference
# $( Dollar Single Parentheses )
# command inside gets run inside a subshell, and then any output gets placed into whatever string you're building.


# (( Double Parentheses ))
# This is for use in integer arithmetic.
# If the result inside is non-zero, it returns a zero (success) exit code.
# If the result inside is zero, it returns an exit code of 1.


# $(( Dollar Double Parentheses ))
# Place the output result into this string


# [ Single Square Brackets ]
# This is an alternate version of the built-in test.
# man test for more info

# [[ Double Square Brackets ]]


# { Single Curly Braces }
# `Single curly braces are used for expansion.



# <( Angle Parentheses )
# ???


# $( Dollar Single Parentheses Dollar Q )$
# ???


