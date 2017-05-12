        #!/bin/bash
# Mejoras
# 1. Si existe la carpeta, borrarla (?)
# 2. Crear bucle con let a+=1 y elegir string(a) para nombrar (y que no sea: _flirted1_flirted2_fnirted4)
# 3. ENCONTRAR FORMA DE SABER NUMERO DE COLUMNAS DE UN VECTOR (opcion: contador en el bucle)

raiz=/home/hose/Escritorio/experimentos/aug-pigs;

# PASOS 1 a 3:
for k in 1 2 3; do
	mkdir $raiz/flirt"$k"	

#	#Elegimos la referencia y los inputs en función de la iteración en la que estemos
	case "$k" in

		1)	lista_ficheros=`find $raiz -name *anat_brain.nii.gz`
			ref=`echo $lista_ficheros | awk '{print $2}'`		# Elegir el que queramos	 
			;;
		2)	#lista_ficheros=`find $raiz -name *anat_brain.nii.gz` #Es la misma que antes
			ref=$raiz/flirt1/template1.nii.gz
			;;
		3)	lista_ficheros=`find $raiz/flirt1 -name *brain_flirted1.nii.gz`  
			ref=$raiz/flirt2/template2.nii.gz
			;;

	esac

	echo " he elegido el caso" "$k"
#
#	# Hago los FLIRTs
	for i in $lista_ficheros; do			    # Iteraciones de hacer los flirts
		ruta=`dirname $i`					    #La ruta completa del fichero 
		fichero=`basename $i`					#El nombre del fichero, con extension
		fichero_noext=`remove_ext $fichero`		#El nombre del fichero, sin extension --> comando para NIFTI solamente!!
		echo $ruta
		echo $fichero
		echo $fichero_noext		
		flirt -in $i -ref $ref -out $raiz/flirt"$k"/"$fichero_noext"_flirted"$k".nii.gz -dof 12 
		echo "flirt terminado"
	done

		


#	# AVERAGING: media de los flirt_k que dará como resultado template_k
#	# Recuerda guardar los template en $ruta para simplificar el codigo
#
	lista_flirt=`find $raiz/flirt"$k" -name *_flirted"$k".nii.gz`
	echo $lista_flirt
	long=3 	#`expr length $lista_flirt`					# Longitud de la cadena (para la division)
	init=`echo $lista_flirt | awk '{print $1}'`			# Para poder iniciar una nueva variable
	cp  $init $raiz/flirt"$k"/avg_aux"$k".nii.gz						# Creo copia auxiliar donde ir sumando imagenes
	echo $long
	echo $init
	for i in $lista_flirt; do		
		fslmaths $raiz/flirt"$k"/avg_aux"$k".nii.gz -add $i $raiz/flirt"$k"/avg_aux"$k".nii.gz	
	echo "haciendo media"						# Sumo todos los ficheros
	done
	
	fslmaths $raiz/flirt"$k"/avg_aux"$k".nii.gz -sub $init $raiz/flirt"$k"/avg_aux"$K".nii.gz #Tengo que quitarlo porque lo he sumado 2 veces
	fslmaths $raiz/flirt"$k"/avg_aux"$k".nii.gz -div $long $raiz/flirt"$k"/template"$k".nii.gz
	
	#rm avg_aux
done	




# 4º Paso: FNIRT 
 	mkdir $raiz/fnirt4
	lista_ficheros=`find $raiz/flirt3 -name *_flirted3.nii.gz`
	ref=$raiz/flirt3/template3.nii.gz
	config_file=/home/hose/Escritorio/SCRIPTS/custom_T1_2_MNI152_2mm.cnf

	for i in $lista_ficheros; do						
				ruta=`dirname $i`					
			fichero=`basename $i`					
			fichero_noext=`remove_ext $fichero`			
			echo $ruta
			echo $fichero
			echo $fichero_noext		
			echo "hago fnirt"
			fnirt --ref=$ref --in=$i --iout=$raiz/fnirt4/"$fichero_noext"_fnirted4.nii.gz #--config=$config_file
	done
	
	# AVERAGING: media de los flirt_k que dará como resultado template_k

	lista_fnirt=`find $raiz/fnirt4 -name *_fnirted4.nii.gz`
	echo $lista_fnirt
	long=3 # `expr length $lista_fnirt`					# Longitud de la cadena (para la division)
	init=`echo $lista_fnirt | awk '{print $1}'`			# Para poder iniciar una nueva variable
	cp  $init $raiz/fnirt4/avg_aux.nii.gz						# Creo copia auxiliar donde ir sumando imagenes
	echo $long
	echo $init
	for i in $lista_fnirt; do		
		fslmaths $raiz/fnirt4/avg_aux.nii.gz -add $i $raiz/fnirt4/avg_aux.nii.gz
	echo "haciendo media"			# Sumo todos los ficheros
	done
	
	fslmaths $raiz/fnirt4/avg_aux.nii.gz -sub $init $raiz/fnirt4/avg_aux.nii.gz	# Tengo que quitarlo porque lo he sumado 2 veces
	fslmaths $raiz/fnirt4/avg_aux.nii.gz -div long $raiz/fnirt4/template4.nii.gz

	#rm avg_aux




# 5º Paso: FLIRT + ATLAS DE SALEAN
 	mkdir $raiz/flirt5
	ref=$raiz/saleau_atlas.nii.gz
	flirt -in $raiz/fnirt4/template4.nii.gz -ref $ref -out $raiz/flirt5/template5.nii.gz -dof 12 
	

# 6º Paso: FNIRT FINAL ---> ATLAS!!
 	mkdir $raiz/fnirt6
	ref=$raiz/saleau_atlas.nii.gz
	config_file=/home/hose/Escritorio/SCRIPTS/custom_T1_2_MNI152_2mm.cnf
	fnirt --ref=$ref --in=$raiz/flirt5/template5.nii.gz --iout=$raiz/fnirt6/pig_atlas.nii.gz --config=$config_file




	
