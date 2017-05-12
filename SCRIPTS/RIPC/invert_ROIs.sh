
        #!/bin/bash

SIN TERMINAR, hacer mas eficiente tambien el codigo
Por ejemplo, tenemos las carpetas 

# Script para extraer timeseries de los ROIs a partir del funcional y las mascaras seleccionadas.

# Poner todas las mascaras en una carpeta, nombradas como xx_mask.nii.gz.
# Recuerda, las mascaras tienen que ser binarias:
#	fslmaths mascaraOriginal -thr 50 -bin mascaraOut   Ejemplo:
#	fslmaths LeftHippocampus -thr 50 -bin LeftHippMask

# Meter en la misma carpeta las matrices de transformación de cada sujeto
#	fmripc001_XX_d1_highres2func_warp  (para struct2func) --> creada por el FEAT
#

lista_warpfields=`find $ruta -name **_highres2standard_warp.nii.gz -depth 3`		# maxdepth indica en cuantas subcarpetas buscar

# Sacamos todas las matrices de standard2functional:
for i in $lista_warpfields
	FALTA QUITAR EL _highres2standard_warp AL NOMBRE Y QUEDARME SOLO CON EL SUJETO
	kk=`echo "$i" | cut -d "_highres2standard_warp" -f 1`

	# 1. Necesitamos obtener la matriz de afinidad standard2struct, que FEAT no la da
	invwarp -w $i -o "$kk"_standard2highres_warp -r highres
done

# Y las aplicamos a todos los ROIs para cada sujeto.
for i in *_ripc	
	name='remove_ext $i'	
	for j in *_mask
		mask='remove_ext $j'
		applywarp -i "$j" -r "$i" -o "$name"_"$mask" -w "$i"_standard2highres_warp --postmat=highres2example_func.mat
														--COMPROBAR ESTE DE ARRIBA--
		EXTRAER timeseries
	done
done												