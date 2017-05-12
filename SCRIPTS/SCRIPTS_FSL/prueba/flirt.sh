        #!/bin/bash

## COMENTARIOS
# Cambiar rutas y nombres de archivos necesarios
# Codigo pensado para ejecutar script desde carpeta con los archivos funcionales origen


# DUDAS:
#	- El flirt lo hacemos para registrar 3D no?, es decir, de 3D a 2D. Para 3D, DOF=12; para 2D, DOF<3.
#	- Metodos de interpolacion. Cual utilizar? (solo se utiliza en la transformacion final. Recuerda que hay dos tipos: 1 directa y otra que primero lo hace de LR->HR y de HR->Ref...cosa que tampoco entiendo por qué)
#	- Funcion de coste. Cual utilizar?
#	- No entiendo el uso que le da a la matriz de afinidad para registrar cuando tiene input y ref. (Userguide pag 11)

# Creo directorio para guardar archivos:
		ruta=`pwd`
		mkdir $ruta/betted/flirted
		cd betted/

# A los archivos de la lista, uno a uno (funcionales ya betteados)
        for i in $( ls ); do

  		kk=`echo "$i" | cut -d "." -f 1`
# Para FSL tambien se puede hacer con: xx=`remove_ext $i`  y te da el nombre del archivo sin la extension					
		# Hago FLIRT a los funcionales ya betteados:
		flirt -ref ~/Escritorio/prueba/structural_brain_pruebas.nii.gz -in ~/Escritorio/prueba/betted/$i -out ~/Escritorio/prueba/betted/flirted/flirt_$kk -omat ~/Escritorio/prueba/betted/flirted/funct2struct_$kk.mat -dof 9     #por defecto es 12	







# El script se puede ejecutar desde cualquier ubicacion
lista_ficheros=`find /home/hose/Escritorio/prueba/`  #aug-pigs/ #8-17-16/H2H4819 -name *.nii`

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
	
done
















		
		#~/Escritorio/prueba/betted/flirted/flirt_$kk 
		#~/Escritorio/prueba/betted/flirted/"func2struct_$kk"".mat"		# Saco tambien matriz de afinidad


		#xx=`flirt -ref $ref_struct -in $ruta/betted/"bet_$i" -dof 6 -omat "func2struct_$kk"".mat"` 
		#mv $xx ~/Escritorio/prueba/betted/flirted/$xx

			


        done

exit

