        #!/bin/bash

# SCRIPT para bet de humanos. Solo se ejecuta sobre los anatomicos, ya que el FNIRT que se realiza sobre los funcionales
# para el coregistro lleva incluido el BET.

# --->> Ejecutar script desde la carpeta donde tengamos los datos!!

# PASA ALGO RARO: DESDE LINEA DE COMANDOS FUNCIONA, PERO EJECUTANDO EL SCRIPT NO..

# Creo directorio para guardar archivos en mi mismo directorio 
# (que deberia ser la carpeta de los datos del sujeto XX):
		ruta=$PWD; 

	# Primero compruebo si ya existe el directorio:	
	if [ ! -d $ruta/bet ]; then
		mkdir $ruta/bet;
	fi

# A los archivos de la lista, uno a uno
	for i in *anat.nii; do
		kk=`echo "$i" | cut -d "." -f 1`;
	#	echo $kk;
	#	echo $i;
		bet2 $i ruta/bet/"$kk"_brain -m -s # Exporta tambien mascaras binarias de cerebro y skull

		# Repasar threshold que queremos poner (fractional intensity) 
		# 	bet $i ruta/bet/"$kk"_bet.nii.gz -R -f 0.5 por defecto
			#	thr<0.5 = mayor segmentación
			#	thr>0.5 menor segmentación
	done
