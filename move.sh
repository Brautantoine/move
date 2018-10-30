#!/bin/bash

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
