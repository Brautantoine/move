#!/bin/bash

#########################################################################################
# <A short bash script to pack all the files in current directory to a new directory>   #
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


if [ -z $1 ]; then
	echo "invalid no arg invoke"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "creating $1"
	mkdir -- $1
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
exit 0
