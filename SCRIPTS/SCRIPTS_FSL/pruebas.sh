        #!/bin/bash

#HAY QUE CAMBIAR LOS ANAT.NII POR ANAT_BRAIN.NII !!!! HACER BET!
raiz=/home/hose/Escritorio/experimentos/aug-pigs/anatomicos;

# PASOS 1 a 3:
for k in 1 2 3; do					# Las sucesivas iteraciones de calcular template 1, template 2..
	mkdir $raiz/flirt"$k"	

	#Elegimos la referencia y los inputs en función de la iteración en la que estemos
	case "$k" in

		1)	lista_ficheros=`find $raiz -name *anat_brain*`
			ref=`echo $lista_ficheros | awk '{print $5}'`		# Elegir el que queramos	 
			;;
		2)	lista_ficheros=`find $raiz -name *anat_brain*`
			ref=$ruta/flirt1/template1.nii.gz
			;;
		3)	lista_ficheros=`find $raiz/flirt1 -name *flirted1*` 
			#lista_ficheros=`find $raiz/flirt2 -name *flirted2*` 
			ref=$ruta/flirt2/template2.nii.gz
			;;

	esac

echo " he elegido el caso" "$k"

	# Hago los FLIRTs
	for i in $lista_ficheros; do				# Iteraciones de hacer los flirts
		ruta=`dirname $i`					#La ruta completa del fichero
		fichero=`basename $i`					#El nombre del fichero, con extension
		fichero_noext=`remove_ext $fichero`			#El nombre del fichero, sin extension
		echo $ruta
		echo $fichero
		echo $fichero_noext		
		flirt -in $i -ref $ref -out $raiz/flirt"$k"/"$fichero_noext"_flirted"$k".nii.gz -dof 12 
echo "flirt terminado"
	done

		


	# AVERAGING: media de los flirt_k que dará como resultado template_k
	# Recuerda guardar los template en $ruta para simplificar el codigo

	lista_flirt=`find $raiz/flirt"$k" -name *_flirted"$k".nii.gz`
echo $lista_flirt
	long=`expr length $lista_flirt`					# Longitud de la cadena (para la division)
	init=`echo $lista_flirt | awk '{print $1}'`			# Para poder iniciar una nueva variable
	cp  $init avg_aux						# Creo copia auxiliar donde ir sumando imagenes
echo $long
echo $init
	for i in $lista_flirt; do		
		fslmaths avg_aux -add $i -add avg_aux
echo "haciendo media"			# Sumo todos los ficheros
	done
	
	fslmaths avg_aux -sub $init avg_aux				# Tengo que quitarlo porque lo he sumado 2 veces
	fslmaths $ruta/flirt"$k"/avg_aux.nii.gz -div long $ruta/flirt"$k"/template"$k".nii.gz
fslview template"$k".nii.gz &


done	

