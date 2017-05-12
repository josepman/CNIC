#!/bin/bash


##############################################
##############################################
# 		2. PREPROCESS B0 IMAGES 
##############################################
##############################################

# sh ./2-b0_prep.sh <path/directories.txt>
# sh ./2-b0_prep.sh /Users/hose/Desktop/CNIC/H2H_Experimentos/HUMANO/FMRIPC_data/001-1/data_renamed.txt


# Manual from: https://osf.io/rqkzc/ , but with the dcm2niix update --> dcm2niix
# Only from March 2017 scans

# Philips provided 4 differents B0_maps in 48 volumes:
#	- 1-12 (included): Modulus (M) (magnitude)
#	- 12-24: Real Part (R)
#	- 25-36: Imag. Part (I)
#	- 37-48: Phase (P)

argc=$#														# Number of arguments
dir_path=("$@")												# Store the list of directories from .txt
directories=`cat $dir_path`									# Path of directoryies (without files)



	for i in $directories; 									# For each directory
	do

		B0_files=`ls $i *B0_*.nii.gz`							# Returns all B0*.nii.gz files in the directory $i (without the path)
		# Check if $B0_files is empty (thus, the directory hasn't B0 files)
		if [[ $B0_files ]];					# If B0_files has something, then
			then

			echo " \n Processing files from ___ $i ____"
			echo " $B0_files \n"

			# 	# 2.1. -- MAGNITUDE & PHASE
		 	# En el b0 devuelve los ficheros separados, por lo que hay que hacer el merge, tanto para phase como para magn.
			fslmerge -t "$i"/B0_mag.nii.gz "$i"/*_B0_0*.nii.gz "$i"/*_B0_10.nii.gz "$i"/*_B0_11.nii.gz "$i"/*_B0_12.nii.gz
			fslmerge -t "$i"/B0_phase.nii.gz "$i"/*_B0_37.nii.gz "$i"/*_B0_38.nii.gz "$i"/*_B0_39.nii.gz "$i"/*_B0_4*.nii.gz

				# 2.2 -- REAL FIELDMAP
				 # Get phase in radians (for FSL)
				fslmaths "$i"/B0_phase.nii.gz -mul 6.28 "$i"/B0_phase_rads.nii.gz

				# Regularization (because is too noisy). Many options (see FSL doc). Here, is used median filtering:
				fugue --loadfmap="$i"/B0_phase_rads.nii.gz -m --savefmap="$i"/B0_phase_rads_reg.nii.gz


			 	# 2 -- MAGNITUDE
			 	bet "$i"/B0_mag.nii.gz "$i"/B0_mag_brain.nii.gz

			 	# Erode it because its noise (remove one voxel from all edges). Be conservative:
			 	fslmaths "$i"/B0_mag_brain.nii.gz -ero "$i"/B0_mag_brain_ero.nii.gz


			# 2.3. -- CHECK CONVERTED FILES (RECOMENDED)
			

			#		Most of the brain has small values (less than 200rad/seg) while in the inferior frontal
			#		and temporal areas the values are larger (either larger and positive or larger and negative)


			# 2.4. REMOVE OLD FILES (optional)

				# We only need (all of them in the same folder!!!):
				#	- B0_phase_rads_reg for FEAT
				#	- B0_magnitude for FEAT
				#	- B0_magnitude_brain_ero for FEAT
				#	- Keep originals PAR/REC files

				rm "$i"/*_ph*
				mv "$i"/B0_mag_brain.nii.gz	"$i"//B0_mag_brain_pre.nii.gz
				# FEAT necesita que se llame _brain, sin el _ero
				mv "$i"/B0_mag_brain_ero.nii.gz "$i"/B0_mag_brain.nii.gz
		else 
			continue
		fi
	done