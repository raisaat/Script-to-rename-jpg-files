#!/bin/bash
#This program renames image files according to the dates they were created on. Command line argument(s) has to be provided. If it is run with 1 as the command line argument, it will rename the files in YYYYMMDD.jpg format. If option 2 is chosen, then the command-line argument should be 2 followed by a string. If option 2 is chosen, then the files will be renamed such that the name of each file starts with the command line string, followed by a three-digit number indicating how old the file is. So for example if the string is foo, the oldest file's name will be foo000.jpg, the second oldest file's name will be foo001.jpg and so on. A command line argument has to be provided and the only valid command line options are a 1, a 2 followed by a string, -h or --help

#assign variables with the help option regular expressions
regex1='^-h$'
regex2='^--help$'
#assign a variable with the description of the program
prog_descr="This program renames image files according to the dates they were created on. Command line argument(s) has to be provided. If it is run with 1 as the command line argument, it will rename the files in YYYYMMDD.jpg format. If option 2 is chosen, then the command-line argument should be 2 followed by a string. If option 2 is chosen, then the files will be renamed such that the name of each file starts with the command line string, followed by a three-digit number indicating how old the file is. So for example if the string is foo, the oldest file's name will be foo000.jpg, the second oldest file's name will be foo001.jpg and so on. A command line argument has to be provided and the only valid command line options are a 1, a 2 followed by a string, -h or --help. The script renames the .jpg files in the directory ~/HW3_data/exif_data. It can be run in the current working directory."

#if the no. of arguments in the command line is not 1 or 2, then print an error message, print the program description and exit from the program
if [[ $# -ne 1 ]] && [[ $# -ne 2 ]]; then
	echo "Error! Incorrect number of command-line arguments provided!"
	echo "$prog_descr" >&2; exit 1
fi

#if there is only one argument and that argument is one of the help options, print the program description and exit from the program
if [[ $1 =~ $regex1 ]] || [[ $1 =~ $regex2 ]] && [[ $# -eq 1 ]]; then
	echo "$prog_descr" >&2; exit 1
fi

#if the no. of arguments in the command line is 2 but the first argument is not equal to 2, then print an error message, print the program description and exit from the program
if [[ $# -eq 2 ]] && [[ $1 != "2" ]]; then
        echo "Error! The first argument has to be 2 if two arguments are provided!"
	echo "$prog_descr" >&2; exit 1
fi

#if the no. of arguments in the command line is 1 but the first argument is not equal to 1, then print an error message, print the program description and exit from the program
if [[ $# -eq 1 ]] && [[ $1 != "1" ]]; then
        echo "Error! The first argument has to be 1 if one argument is provided!"
	echo "$prog_descr" >&2; exit 1
fi

#print the program description
echo "$prog_descr"
#assign a variable with the pathname of the directory which contains the .jpg files to be renamed
FILE_PATH="$HOME/HW3_data/exif_data"
#If option 1 is chosen
if [ $1 -eq 1 ]; then
	#Loop through all the .jpg files in the directory
	for f in "$FILE_PATH"/*.jpg; do
		#assign a variable with a command that will get the exif data of each file and extract the date from it
		exif_date=($(identify -verbose "$f" | grep exif | grep DateTimeOriginal | awk '{print $2}' | cut -dT -f1))
		#assign a variable with the year in which the file was created
		a=($(echo $exif_date | awk -F '[:-]' '{print $1}'))
		#assign a variable with the month in which the file was created
		b=($(echo $exif_date | awk -F '[:-]' '{print $2}'))
		#assign a variable with the day in which the file was created
		c=($(echo $exif_date | awk -F '[:-]' '{print $3}'))
		#rename the file in YYYYMMDD.jpg format
		mv "$f" "$FILE_PATH/$a$b$c.jpg"
	done
#If option 2 is chosen
elif [ $1 -eq 2 ]; then
        array=()
	#Loop through every .jpg file in the directory and assign each file's date to an element of array
	for f in "$FILE_PATH"/*.jpg; do array+=($(identify -verbose "$f" | grep exif | grep DateTimeOriginal | awk '{print $2}' | cut -dT -f1)); done
	#sort the elements in array and assign its sorted contents to a new array called sorted
	readarray -t sorted < <(for a in "${array[@]}"; do echo "$a"; done | sort)
	for f in "$FILE_PATH"/*.jpg; do
		x=0
		#If the file's date matches a date in sorted array, rename the file with string followed by a number
		for a in "${sorted[@]}"; do
			if [ "$(identify -verbose "$f" | grep exif | grep DateTimeOriginal | awk '{print $2}' | cut -dT -f1)" == "$a" ]; then
				mv "$f" "$FILE_PATH"/`printf %s%03d%s $2 $x ".jpg"`
				break
			fi
			((x++))
			done
		done
fi
