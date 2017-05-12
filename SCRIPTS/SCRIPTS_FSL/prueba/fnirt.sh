        #!/bin/bash

## COMENTARIOS
# Cambiar rutas y nombres de archivos necesarios
# Codigo pensado para ejecutar script desde carpeta con los archivos funcionales origen


# Creo directorio para guardar archivos:
		ruta=`pwd`
		mkdir $ruta/betted/flirted
		ref_struct= $ruta/structural_brain_pruebas.nii.gz		### <----- fichero Struct de referencia
		
# A los archivos de la lista, uno a uno
        for i in $( ls ); do

  		kk= `echo "$i" | cut -d "." -f 1`					#Me quedo con el nombre, sin ".nii.gz" (quito desde .)
		# Hago FLIRT a los funcionales ya betteados:
		flirt -ref $ref_struct -in $ruta/betted/"bet_$i" -out $ruta/betted/flirted/flirt_$kk 	#~/Escritorio/prueba/betted/flirted/flirt_$kk 
		flirt -ref $ref_struct -in $ruta/betted/"bet_$i" -dof 6 -omat $ruta/betted/flirted/flirt_$kk 	#~/Escritorio/prueba/betted/flirted/"func2struct_$kk"".mat"		# Saco tambien matriz de afinidad


		#xx=`flirt -ref $ref_struct -in $ruta/betted/"bet_$i" -dof 6 -omat "func2struct_$kk"".mat"` 
		#mv $xx ~/Escritorio/prueba/betted/flirted/$xx

			


        done

exit
