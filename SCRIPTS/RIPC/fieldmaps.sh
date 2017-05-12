        #!/bin/bash

# Preparar los fieldmaps para el B0 y el coregistro del funcional con el estructural
# Debemos tener tanto la magnitud como la fase del Fieldmap:
#	- xx_d1_FMAP_MAG.nii.gz
#	- xx_d1_FMAP_PHASE.nii.gz

# Seleccionar directorio de operacion
# cd XXXXXX

# Hacemos BET a todos los mapas de magnitud, y le quitamos dirty voxels con -ero de fslmaths

for i in FMAP_MAG*
	xx = 'remove_ext $i'
	bet2 $i "$xx"_brain  
	fslmaths "$xx"_brain -ero "$xx"_brain_ero
done

Queda: 

Hacer la reconstruccion del B0 de cada imagen. Preguntar a Javi

Processing the fieldmap phase difference image

Here we need to take this raw scanner output, which is scaled in a strange way (0 to 360 degrees are mapped to 0 to 4096), and convert it into radians
per second image (this is equivalent to an image in Hz multiplied by 2*pi). For this we need the phase difference image, the brain extracted (and
eroded) magnitude image and the difference in the echo times of the fieldmap acquisitions. This latter value is 2.46ms and can be found in the text file
FMAPS.txt, which is conveniently given here but will not exist normally. Therefore it is important to record this echo time difference when you scan (your
scanner operator will be able to give you the value, and although it can usually be determined later on, it is much easier to record it at the time when the
scanner operator is present).
Armed with this information, all we need to do is run the GUI called Fsl_prepare_fieldmap. Note that these images come from a Siemens scanner. Set
up all the information required in the GUI, (phase image is FMAP_PHASE.nii.gz and the brain extracted magnitude image is
FMAP_MAG_brain_ero.nii.gz) calling the output FMAP_RADS, and press Go. View the output with fslview and check that most of the brain has small
values (less than 200 rad/s) while in the inferior frontal and temporal areas the values are larger (either large and positive or large and negative).


