        #!/bin/bash

# El script se puede ejecutar desde cualquier ubicacion
lista_ficheros=`find /home/hose/Escritorio/experimentos/aug-pigs/ -name *.nii` #8-17-16/H2H4819

# Hago lista de todos los .nii de mis experimentos y la guardo en variable lista_ficheros
#lista_ficheros=`find /home/hose/Escritorio/prueba/ -name *.nii -maxdepth 4`
#tt=`echo $lista_ficheros | awk '{print $100}'`
#max=32767;

#echo $lista_ficheros

# Ahora compruebo uno a uno los dinamicos que tiene cada uno de los archivos de la lista
for i in $lista_ficheros; do
	#fichero=`echo $lista_ficheros | awk '{print $i}'`
	#num=`fslnvols $fichero`
	num=`fslnvols $i`	
	res=`echo "$num > 300" | bc`

	# Si resulta que tiene mas dinamicos de los que deberia
	if [ $res = 1 ]; then
		ruta=`dirname $i`					#La ruta completa del fichero
		fichero=`basename $i`					#El nombre del fichero, con extension
		fichero_noext=`remove_ext $fichero`			#El nombre del fichero, sin extension
		echo $ruta
		echo $fichero
		echo $fichero_noext		
		
		mkdir $ruta/aux						#Creo carpeta auxiliar para trabajar en ella
		#fichero=$(echo $i | sed -e 's;:\?/home/user/bin;;' -e 's;/home/user/bin:\?;;')
	
		cd $ruta						#Me muevo a la carpeta del fichero
		cp $fichero $ruta/aux/$fichero				# Genero copia en la nueva carpeta creada
		cp $fichero "$fichero_noext"_copiaseguridad.nii		#Recomendado hacer copia de seguridad 			
		cd $ruta/aux						#Y trabajo con la otra copia en la carpeta nueva
		
		fslsplit $fichero					#Separo en dinamicos
		#for x in {vol0000 ... vol0259};do
		for x in vol03* vol04*; do				#Elimino los que no quiero
			rm $x
		done


		fslmerge  -t "$i" vol*				#Hago merge. Exporto a la ubicacion original con el 									nombre original (el resultado pisa al original)
		cd ..
		#rm -R aux/					# Elimino rastro
		#rm "$i"_copiaseguridad				#Se puede hacer otra lista y borrar todas las copias una vez comprobado que el script ha funcionado bien
		
	else
		echo "no entro"
	fi
	
done
