        #!/bin/bash

# Hay que lanzar el 
#lista_ficheros=`find /home/hose/Escritorio/aug-pigs/8-17-16/H2H4819 -name *.nii`
lista_ficheros=`find /home/hose/Escritorio/ -name *.nii`
#tt=`echo $lista_ficheros | awk '{print $100}'`
#max=32767;

echo $lista_ficheros

#for i in ($lista_ficheros); do
for i in $lista_ficheros; do
	#fichero=`echo $lista_ficheros | awk '{print $i}'`
	#num=`fslnvols $fichero`
	num=`fslnvols $i`	
	res=`echo "$num > 300" | bc`
	ruta=`cd .. | pwd`
	echo $i
	echo $ruta

	if [ $res = 1 ]; then
		
		mkdir processing
		fichero=$(echo $i | sed -e 's;:\?/home/user/bin;;' -e 's;/home/user/bin:\?;;')
		mv $i $i/processing
		cd processing/
		
		fslsplit $i				#Separo en dinamicos
		#for x in {vol0000 ... vol0259};do
		for x in vol03* vol04*; do	#Elimino los que no quiero
			rm $x
		done
		
		xx=`remove_ext $i`
		new=`fslmerge  -t "$xx"_merged vol*`			#Y hago merge de los que quedan, 										guardandolo con el mismo nombre que antes
		mv "$xx"_merged.nii.gz $ruta/"$xx".nii.gz		
		cd ..
		rm -R processing
		
	else
		sleep 1
	fi
	
done
