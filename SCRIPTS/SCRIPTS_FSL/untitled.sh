# PARA HACER LA LISTA DE ARCHIVOS
#lista_ficheros=`find $ruta -name *.nii -maxdepth 4`		# maxdepth indica en cuantas subcarpetas buscar
#tt=`echo $lista_ficheros | awk '{print $10}'`				# Esta linea se queda con el elemento 10 de la lista



for i in $lista_ficheros; do
	#fichero=`echo $lista_ficheros | awk '{print $i}'`
	#num=`fslnvols $fichero`
	num=`fslnvols $i`	
	res=`echo "$num > 300" | bc`

	# Si resulta que tiene mas dinamicos de los que deberia
	if [ $res = 1 ]; then
		echo "VAMOOOOOOOOOOOOOOOOOOS"
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
		


		######### FLIRT a los funcionales ya betteados:
		flirt -ref ~/Escritorio/prueba/structural_brain_pruebas.nii.gz -in ~/Escritorio/prueba/betted/$i -out ~/Escritorio/prueba/betted/flirted/flirt_$kk -omat ~/Escritorio/prueba/betted/flirted/funct2struct_$kk.mat -dof 9     #por defecto es 12



		cd ..
		#rm -R aux/					# Elimino rastro
		#rm "$i"_copiaseguridad				#Se puede hacer otra lista y borrar todas las copias una vez comprobado que el script ha funcionado bien
		
	else
		echo "no entro"
	fi