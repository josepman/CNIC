        #!/bin/bash


# SCRIPT para realizar flirt en una lista de imagenes ya beteadas sobre el MISMO SUJETO. Se debe:
#	- Lanzar comando desde la carpeta de ejecucion. El script flirt.sh no tiene por qué estar en la misma carpeta.
#	- Tener la referencia structural_brain.nii.gz en carpeta ejecucion(pwd)
#	- Tener una subcarpeta "bet" donde estan todos los beteados (pwd/bet)

# Todos los flirteds se guardaran en una carpeta "pwd/flirted" con el nombre xxx_flirted.nii.gz
# Además, se exportará la matriz funct2struct (para el applywarp) para hacer los sucesivos flirts.


####################

# DUDAS:
#	- Metodos de interpolacion. Cual utilizar? (solo se utiliza en la transformacion final. Recuerda que hay dos tipos: 1 directa y otra que primero lo hace de LR->HR y de HR->Ref...cosa que tampoco entiendo por qué)
#	- Funcion de coste. Cual utilizar?

####################


# Creo directorio para guardar archivos:
		ruta=$PWD
		mkdir $ruta/flirted

# Genero mi lista 		
#lista_ficheros=`find $ruta -name *.nii -maxdepth 2`		# maxdepth indica en cuantas subcarpetas buscar
lista_ficheros=`find $ruta/bet -name *_bet.nii`		# maxdepth indica en cuantas subcarpetas buscar
aux=`echo $lista_ficheros | awk '{print $1}'`			# Esta linea se queda con el elemento 1 de la lista
aux_name=`echo "$i" | cut -d "." -f 1`;					# Quito extensión para el nombre

# Con este archivo realizo un flirt. El objetivo es obtener la matriz de conversión struct2funct
flirt -ref $ruta/structural_brain.nii.gz -in $ruta/bet/$aux -out $ruta/flirted/"$aux_name"_flirted.nii.gz -omat $ruta/funct2struct.mat -dof 9     #por defecto es 12	


# Una vez que tengo la matriz de transformación, la multiplico por el resto de archivos (mas eficiente computacionalmente)
    #for i in $( ls ); do
    for i in $lista_ficheros; do	
  		xxx=`echo "$i" | cut -d "." -f 1`			# Para quedarme con el nombre, sin la extensión		
        # Para FSL tambien se puede hacer con: kk=`remove_ext $i`  y te da el nombre del archivo sin la extension					
		flirt -ref $ruta/structural_brain.nii.gz -in $ruta/bet/$i -out $ruta/flirted/"$xxx"_flirted.nii.gz -applyxfm -init $ruta/funct2struct.mat 
    done

exit

