        #!/bin/bash

# SCRIPT para bet de cerdos. Es mas coñazo. Repasar coordenadas correctas para el anatomico y para el funcional.

# --->> Ejecutar script desde la carpeta donde tengamos los datos!!

# PASA ALGO RARO: DESDE LINEA DE COMANDOS FUNCIONA, PERO EJECUTANDO EL SCRIPT NO..

# Creo directorio para guardar archivos en mi mismo directorio 
# (que deberia ser la carpeta de los datos del sujeto XX):
		ruta=$PWD;

	# Primero compruebo si ya existe el directorio:	
	if [ ! -d $ruta/bet ]; then
		mkdir $ruta/bet;
	fi

# PARA EL ANATOMICO
	for i in *anat.nii; do
		kk=`echo "$i" | cut -d "." -f 1`;
		bet $i $ruta/bet/"$kk"_bet.nii.gz -c 176 177 70 -R  	#
	done

# PARA LOS FUNCIONALES
	for i in *fxn.nii; do
		kk=`echo "$i" | cut -d "." -f 1`;
		bet $i $ruta/bet/"$kk"_bet.nii.gz -c 70 73 9 -f 0.35 -R -F	
	done