#!/bin/bash

#########################################################################################
# A short bash script to pack all the files in current directory to a new directory     #
#    Copyright (C) 2018  Antoine Braut						        #
#										        #
#    This program is free software: you can redistribute it and/or modify		#
#    it under the terms of the GNU General Public License as published by		#
#    the Free Software Foundation, either version 3 of the License, or			#
#    (at your option) any later version.						#
#											#
#    This program is distributed in the hope that it will be useful,			#
#    but WITHOUT ANY WARRANTY; without even the implied warranty of			#
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			#
#    GNU General Public License for more details.					#
#											#
#    You should have received a copy of the GNU General Public License			#
# along with this program. If not, see <https://www.gnu.org/licenses/>.			#
#											#
# Contact : Antoine.braut@gmail.com							#
#											#
#########################################################################################

display_help()
{
	echo "move - version 0.0 (beta)
A short script utils to pack all the files in current directory
into a new directory

	Usage : move [options] <dest_dir> <regexp>

	Options :
	-h | -H | --help - Show this message
	-v | --version   - Show version
	-s | --source	 - Not implemented yet
	-i | --ignore	 - Ignore files whithout regexp"
}

display_version()
{
	echo "0.2"
}

no_opt=1
opt_ign=0

while getopts ":hHsvi-:" opt ; do
	case $opt in
		h ) 
			display_help 
			exit 0 ;;
		H ) 
			display_help 
			exit 0 ;;
		s )
			echo source
			no_opt=0
			exit 0 ;;
		v )
			display_version
			exit 0 ;;
		i )
			no_opt=0
			opt_ign=1 ;;
		- ) case $OPTARG in
			help ) 
				display_help
				exit 0 ;;
			source )
				echo source
				no_opt=0
				exit 0 ;;
			version )
				display_version 
				exit 0 ;;
			ignore )
				no_opt=0
				opt_ign=1 ;;
			* )
				echo "Unrecognized option : --$OPTARG"
				display_help
				exit 1 ;;
			esac ;;
	esac
done
shift $(($OPTIND-1))
			
if [ -z $1 ]; then
	echo "invalid no arg invoke"
	echo " "
	display_help
	exit 1
fi

#if [[ "$1" == "--help" || "$1" == "-h" ]]; then
#	display_help
#	exit 0
#fi

if [ $opt_ign -ne 0 ]; then

	if [ -z $2 ]; then
		echo missing argument
		display_help
		exit 1
	fi
	
	if [ ! -d $1 ]; then
		echo "creating $1"
		mkdir -p -- $1
	fi

	for item in  ./*
	do
		count=$((count+1))
	done

	echo Number total of files : $count
	
	for chaine in *
	do
		echo "$chaine" | grep "$2" > /dev/null
		if [ $? -eq 0 ]; then
			echo move $chaine to $1
		else
			echo skipping $chaine
		fi
	done	
fi

if [ $no_opt -ne 0 ]; then

	if [ ! -d $1 ]; then
		echo "creating $1"
		mkdir -p -- $1
	fi
	for item in  ./*
	do
		count=$((count+1))
	done
	echo Number total of files : $count
	for file in * 
	do
		progress=$((progress+1))
		if [[ ! ${file} == $1 ]];then
			echo moving \[${file}\] in $1  \[$(((progress*100/count*100)/100))%\]
			mv ${file} $1
		else
			echo skipping \[${file}\]  \[$(((progress*100/count*100)/100))%\]
		fi
		
	done
	echo transfer finished with succes
fi
exit 0
