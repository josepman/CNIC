#!/bin/bash


##############################################
# 1. CONVERT PAR/REC FILES TO NII WITH DCM2NII
##############################################

# sh ./1-par2nii.sh <path/listfiles.txt>
# sh ./1-par2nii.sh /Users/hose/Desktop/CNIC/H2H_Experimentos/HUMANO/FMRIPC_data/001-1/data_renamed.txt

# dcm2niix search automatically each .PAR (header) (o .REC (image), both report the same result) file
# in the directory specifiec.

# dcm2niix returns:
#	- .json (header of file)
#	- .nii image converted

argc=$#								# number of arguments
argv=("$@")							# store the argument (as an array)

raw_data=`cat $argv`


if [ $argc -ne 1 ]; then		
  	echo "Error: You must specify the list of .PAR files (complete path, including the file and extension)"
   	echo "  sh ./1-par2nii.sh <listfile> [config_file_path]"
   	exit
fi

echo "esto es argv!!!!"
echo "$argv"
echo "y esto lo que hay dentro"
echo "$raw_data"

	for i in $raw_data; 
	do
		dirfile=`dirname $i`
		filename=`basename $i`						# Name of file, with the extension
		file_noext=`basename $i .PAR`

		if [ -f "$dirfile"/"$file_noext".nii ]		
			then	
			echo "Converted file of $i already exist"
		
		else

			echo "Files converted from $i not prepared--> START conversion from PAR/REC files"
			/usr/local/bin/dcm2niix -z y -f "$file_noext" $i 	#$b0_file 
			# more options in: https://www.nitrc.org/plugins/mwiki/index.php/dcm2nii:MainPage#General_Usage

			#	-z: output format (y=nii.gz; n=.nii)
			#	-f: name of output file (without extension)
			# 	Always the last parameter is the input file

					# Para externalizar este proceso a la cola de un servidor/cluster:
					# fsl_sub -q *.q /usr/local/bin/dcm2niix -z y -f "$file_noext" $i 

			echo "FILE $filename CONVERTED!"
		fi


		if [ ! -d "$dirfile"/0.RAW_DATA ]		
			then	
			mkdir "$dirfile"/0.RAW_DATA
		fi

		mv $i "$dirfile"/0.RAW_DATA
		mv "$dirfile"/"$file_noext".REC "$dirfile"/0.RAW_DATA

	done