#!/bin/bash

function ft_duplucate()
{
	file_tudup=$1
	path=${2:-$(pwd)}

	if [ $# -lt 1 -o $# -gt 2 ]
	then
		echo  Error : Arguments
		[ $# -lt 1 ] && echo  please specify file tu duplicate white
	elif ! [ -e $file_tudup ]
	then
		echo  Error : \'$1\' no such file or diroctory
	elif ! [ -d $path ]
	then
		echo  Error : \'$2\' no such  diroctory
	elif ! [ -d $file_tudup ]
	then
		touch ${path}/${file_tudup##*/}
	else
		mkdir ${path}/${file_tudup##*/}
		files=$(ls $file_tudup)
		for file in $files
		do
			(ft_duplucate $file_tudup/$file ${path}/${file_tudup##*/})
		done
	fi
}

ft_duplucate $@