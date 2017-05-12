#!/bin/bash

# Script para preparar los datos a partir de los PAR/REC

#./prepare_data.sh <fmri_dir> 



##############################################
##############################################
#     		PRINCIPAL PARAMETERS
##############################################
##############################################
argc=$#								# number of arguments
argv=("$@")							# store the argument (as an array)

if [ $argc -ne 1 ]; then		
  	echo "Error: You must specify the fmri file path (only path, without name of fmri file)"
   	echo " sh ./prepare_data.sh <fmri_dir> [config_file_path]"
   	exit
fi
 						
route="${argv[0]}"									# First argument: directory of fmri datafiles
#raw_data=`ls -R $route *.PAR`
par_data=`find $route -type f -name *.PAR`			# PAR/REC listfile in the directory			
log_data=`find $route -type f -name *.log`	

##### TO CHECK AND TO COMPARE WITH PRIOR data.txt! (they are dated)###
aa=`echo "$par_data $log_data"`
orig=`pwd`
day=$(date +"%m_%d_%Y") 
ls $aa  > "$orig"/"$day"data.txt		# Export list of files in data.txt



##############################################
##############################################
# 			0. RENAME FILES
##############################################
##############################################
sh ./0-renameFiles.sh "$orig"/"$day"data.txt

# Update the state
par_data=`find $route -type f -name *.PAR`			# PAR/REC listfile in the directory			
log_data=`find $route -type f -name *.log`	

echo "\n"
echo "##############################################"
echo "###########    LISTFILE RENAMED    ###########"
echo "##############################################"
echo " ________ par_data (renamed) _________"
echo "$par_data" 
echo " ________ log_data (renamed) _________"
echo "$log_data" 

aa=`echo "$par_data"`
ls $aa  > "$orig"/"$day"data_renamed.txt

## MAYBE REORDER FILES IN DIRECTORY??



##############################################
##############################################
# 1. CONVERT PAR/REC FILES TO NII WITH DCM2NII
##############################################
##############################################
sh ./1-par2nii.sh "$orig"/"$day"data_renamed.txt

# Update the state
nifti_data=`find $route -type f -name *.nii.gz`			# PAR/REC listfile in the directory				

echo "\n"
echo "###############################################"
echo "#######   PAR_DATA CONVERTED TO NII.GZ  #######"
echo "###############################################"
echo " __________________(check files)_______________"
echo "$nifti_data" 



##############################################
##############################################
# 		2. PREPROCESS B0 IMAGES 
##############################################
##############################################

find $route -type d > "$day"directories.txt

echo "\n"
echo "###############################################"
echo "#########     PREPROCESS B0 IMAGES    #########"
echo "###############################################"
 
sh ./2-b0_prep.sh "$orig"/"$day"directories.txt



