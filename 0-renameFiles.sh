#!/bin/bash

##############################################
# 0. CHANGE NAMES OF FILES
##############################################

# sh ./0-renameFiles.sh <path/listfiles.txt>
# sh ./0-renameFiles.sh /Users/hose/Desktop/CNIC/H2H_Experimentos/HUMANO/FMRIPC_data/001-1/data.txt

argc=$#								# number of arguments
argv=("$@")							# store the argument (as an array)

if [ $argc -ne 1 ]; then		
  	echo "Error: You must specify the list of .PAR files to change their names (complete path, including the file and extension)"
   	echo "  sh ./0-renameFiles.sh <listfiles> [config_file_path]"
   	exit
fi

datalist=`cat $argv`

echo "\n"
echo "##############################################"
echo "      -          FILES TO RENAME         -    "
echo " ____structname: /grandpa/daddy/RIP_WPI_DTI_SENS_9.1....ext  ---> /001/D3/001_D3_DTI.PAR  _____"
echo " ____LISTFILE.TXT in: $argv   _______"	
echo "##############################################"	
echo " ____LIST OF FILES: _____"
echo "$datalist"




for i in $datalist; 
do

		dirfile=`dirname $i`
		filename=`basename $i`						# Name of file, with the extension

		## ARREGLAR:
		f1=`cut -d/ -f9 <<<"$i"`		#Se queda SOLO con el termino que haya despues del 9º slash (y antes del 10)
		f2=`cut -d/ -f10 <<<"$i"`
		id_file="$f1"_"$f2"	

	# FOR PAR/REC FILES
	if [[ $i == *".PAR"* ]]
		then
		file_noext=`basename $i .PAR`
			if [[ $filename == *"T1"* ]]
			then
				mv $i "$dirfile"/"$id_file"_T1.PAR
				mv "$dirfile"/"$file_noext".REC "$dirfile"//"$id_file"_T1.REC

			elif [[ $filename == *"BO"* ]]
			then
				mv $i "$dirfile"/"$id_file"_B0.PAR
				mv "$dirfile"/"$file_noext".REC "$dirfile"/"$id_file"_B0.REC

			elif [[ $filename == *"TAPP"* ]]
			then
				mv $i "$dirfile"/"$id_file"_tapping.PAR
				mv "$dirfile"/"$file_noext".REC "$dirfile"/"$id_file"_tapping.REC

			elif [[ $filename == *"REST"* ]]
			then
				mv $i "$dirfile"/"$id_file"_REST.PAR
				mv "$dirfile"/"$file_noext".REC "$dirfile"/"$id_file"_REST.REC

			elif [[ $filename == *"GORDO"* ]]
			then
				mv $i "$dirfile"/"$id_file"_REST.PAR
				mv "$dirfile"/"$file_noext".REC "$dirfile"/"$id_file"_REST.REC

			elif [[ $filename == *"DTI"* ]]
			then
				mv $i "$dirfile"/"$id_file"_DTI.PAR
				mv "$dirfile"/"$file_noext".REC "$dirfile"/"$id_file"_DTI.REC
			fi


# FOR LOGS FILES
	elif [[ $i == *".log"* ]]
		then
		file_noext=`basename $i .log`

			if [[ $filename == *"t1"* ]]
			then
				mv $i "$dirfile"/"$id_file"_t1.log

			elif [[ $filename == *"b0"* ]]
			then
				mv $i "$dirfile"/"$id_file"_b0.log

			elif [[ $filename == *"tapping"* ]]
			then
				mv $i "$dirfile"/"$id_file"_FING.log

			elif [[ $filename == *"rest"* ]]
			then
				mv $i "$dirfile"/"$id_file"_REST.log

			elif [[ $filename == *"GORDO"* ]]
			then
				mv $i "$dirfile"/"$id_file"_REST.log

			elif [[ $filename == *"dti"* ]]
			then
				mv $i "$dirfile"/"$id_file"_dti.log
			fi
	fi
done




