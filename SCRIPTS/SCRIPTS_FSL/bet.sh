        #!/bin/bash


# Creo directorio para guardar archivos en mi mismo directorio 
# (que deberia ser la carpeta de los datos del sujeto XX):
		ruta=`pwd`

	# Primero compruebo si ya existe el directorio:	
	if [ ! -d "$ruta/bet" ]; then
		mkdir bet;
	else
		rm -r $ruta/bet 	#Elimino viejos archivos de la carpeta
	fi


# Ahora, genero la lista de ficheros a los que voy a hacer el bet
# NOTA: Definir antes la carpeta XXXXX donde vamos a buscar los ficheros!

# cd XXXXX
	for i in *.nii.gz; do
		kk=`echo "$i" | cut -d "." -f 1`
		bet $i $ruta/bet/"$kk"_bet.nii.gz
	done
