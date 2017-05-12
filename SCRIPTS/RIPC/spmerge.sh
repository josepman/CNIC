        #!/bin/bash


# Meter todos los funcionales en la misma carpeta para ejecutar el script.

# Los resultados se separarán en:
#	- Ficheros xx_rest-pre.nii.gz de los primeros 10 minutos de cada sesión (300 dyn)
#	- Ficheros xx_ripc.nii.gz de las pruebas de precondicionamiento (30 min = 900 dyn)
#	- Ficheros xx_sham.nii.gz de las pruebas de sham (30 min = 900 dyn)
#	- Ficheros xx_rest-post.nii.gz del rest final (300 dyn)

	# d1 siempre va a ser sham
	# d3 siempre va a ser RIPC

# Ejecutar sobre el mismo directorio de los archivos!!
# Sino, habilitar la siguiente linea:
# cd DIRECTORIO 

# Deshabilitar las 4 siguientes lineas si ya existen dichas carpetas
	mkdir ripc ripc/restin
	mkdir sham sham/resting
	mkdir d2
	mkdir d4

# Para SHAM
for i in _d1.nii; do
	fslsplit $i -t			# Separo en dinamicos

	xx='remove_ext $i'		# Me quedo solo con el nombre
	# xx debería ser algo como: fMRI-PC-001-d1


	# Rest-pre
	fslmerge "sham/resting/$xx_rest-pre" -t vol00* vol01*

	# sham
	fslmerge "sham/$xx_sham" -t vol02* vol03* vol04* vol05* vol06* vol07* vol08* vol09* vol10* vol11*

	# Rest-post
	fslmerge "sham/resting/$xx_rest-post" -t vol00* vol01*

	# Limpiamos
	rm vol*
done

# Para RIPC
for i in _d3.nii; do
	fslsplit $i -t			# Separo en dinamicos

	xx='remove_ext $i'		# Me quedo solo con el nombre

	# Rest-pre
	fslmerge "resting/$xx_rest-pre" -t vol00* vol01*

	# RIPC
	fslmerge "ripc/$xx_ripc" -t vol02* vol03* vol04* vol05* vol06* vol07* vol08* vol09* vol10* vol11*

	# Rest-post
	fslmerge "resting/$xx_rest-post" -t vol00* vol01*

	# Limpiamos
	rm vol*
done

