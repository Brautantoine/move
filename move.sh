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
	echo "move - version 1.1.0 (alpha)
A short script utils to pack all the files in current directory
into a new directory

	Usage : move [options] <dest_dir>
		move [options] <dest_dir> <regexp>

	Options :
	-h | -H | --help - Show this message
	-v | --version   - Show version
	-s | --source	 - Not implemented yet
	-p | --precise	 - Skip files whithout regexp
	-d | --hidden	 - Move hidden files too
"
}

display_version()
{
	echo "move - version 1.1.0 (alpha)"
}

no_opt=1
opt_prec=0
opt_hid=0

while getopts ":dhHvsp-:" opt ; do
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
		p )
			no_opt=0
			opt_prec=1 ;;
		d )
			no_opt=0
			opt_hid=1 ;;
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
			precise )
				no_opt=0
				opt_prec=1 ;;
			* )
				echo "Unrecognized option : --$OPTARG"
				display_help
				exit 1 ;;
			esac ;;
		* )
			echo Unrecognized option : $opt
			display_help
			exit 1 ;;
	esac
done
shift $(($OPTIND-1))

dest_dir=$1
			
if [ -z ${dest_dir} ]; then
	echo "invalid no arg invoke"
	echo " "
	display_help
	exit 1
fi

#if [[ "${dest_dir}" == "--help" || "${dest_dir}" == "-h" ]]; then
#	display_help
#	exit 0
#fi
if [ $opt_hid -ne 0 ]; then
	shopt -s dotglob
fi

if [ $opt_prec -ne 0 ]; then

	if [ -z $2 ]; then
		echo missing argument
		display_help
		exit 1
	fi
	
	if [ ! -d ${dest_dir} ]; then
		echo "creating ${dest_dir}"
		mkdir -p -- ${dest_dir}
	fi

	for item in  ./*
	do
		count=$((count+1))
	done

	echo Number total of files : $count
	
	for file in *
	do
		progress=$((progress+1))
		echo "$file" | grep "$2" > /dev/null
		if [ $? -eq 0 ]; then
			if [[ ! ${file} == ${dest_dir} ]]; then
				echo moving \[${file}\] in ${dest_dir}  \[$(((progress*100/count*100)/100))%\]
				mv ${file} ${dest_dir}
			else
				echo skipping \[${file}\] in ${dest_dir} \[$(((progress*100/count*100)/100))%\]
			fi
		else
			echo skipping \[${file}\]  \[$(((progress*100/count*100)/100))%\]
		fi
	done	
fi

if [ $no_opt -ne 0 ]; then

	if [ ! -d ${dest_dir} ]; then
		echo "creating ${dest_dir}"
		mkdir -p -- ${dest_dir}
	fi
	for item in  ./*
	do
		count=$((count+1))
	done
	echo Number total of files : $count
	for file in * 
	do
		progress=$((progress+1))
		if [[ ! ${file} == ${dest_dir} ]];then
			echo moving \[${file}\] in ${dest_dir}  \[$(((progress*100/count*100)/100))%\]
			mv ${file} ${dest_dir}
		else
			echo skipping \[${file}\]  \[$(((progress*100/count*100)/100))%\]
		fi
		
	done
	echo transfer finished with succes
fi

if [ $opt_hid -ne 0 ]; then
	shopt -u dotglob
fi

exit 0
