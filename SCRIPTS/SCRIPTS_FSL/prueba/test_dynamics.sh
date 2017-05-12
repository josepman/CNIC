        #!/bin/bash

#lista_ficheros=`find /home/hose/Escritorio/aug-pigs/ -name *.nii`		#Hace una busqueda de todos los archivos .nii
#tt=`echo $lista_ficheros | awk '{print $100}'`


#for
	for i in *.nii; do
		num=`fslnvols $i`
		res=`echo "$num > 300" | bc`
		if [ $res = 1 ]; then
			mkdir processing
			ruta=`pwd`
			mv $i $ruta/processing/$i
			cd processing/
		
			fslsplit $i				#Separo en dinamicos
			for x in {vol0000 ... vol0259};do
			#for x in vol03* vol04*; do	#Elimino los que no quiero
				rm $x
			done
		
			xx=`remove_ext $i`
			new=`fslmerge  -t "$xx"_merged vol*`			#Y hago merge de los que quedan, guardandolo con el mismo nombre que antes
			mv "$xx"_merged.nii.gz $ruta/"$xx".nii.gz		
			cd ..
			rm -R processing
		
		else
			sleep 1
		fi
	
	done
#done


