#raiz=/home/hose/Escritorio/mkfxnl;	#Directorio donde esten todos los funcionales
raiz=$PWD


## Para FEAT del 1º nivel:	
	list_fxnl=`find $raiz/ -name *_RUN*`
	echo $lista_fxnl 									# Tiene que haber 108 funcionales
	cp $raiz/.feat0/design.fsf $raiz/aux_design.fsf 
	old_name=restfxnl													#### CAMBIAR!!

	for i in list_fxnl; do
		ruta=`dirname $i`					    		#La ruta completa del fichero 
		fichero=`basename $i`							#El nombre del fichero, con extension
		new_name=`remove_ext $fichero`					#El nombre del fichero, sin extension --> comando para NIFTI solamente!!
		#bet $i $ruta/"$fichero_noext"_fxbet.nii.gz -c 60 58 71		#REPASAR COORDENADA
		vim $raiz/aux_design.fsf
			:%s/"$old_name"/"$new_name"/g 				#comando(:) buscar(s) en todo el fichero(%) y cambiar "/old_name" por "/new_name" cada vez que lo encuentre y no solo la primera vez(g)
			:wq											#Guardar (w) y salir (q)
		feat $raiz/aux_design.fsf &
		old_name=$new_name
		let a+=1
		echo "Feat numero $a terminado!"
	done

		
## Para FEAT del 2º nivel:


# Para introducir parametros por teclado:
# echo "introduce valor para x: "
# read x
# echo $x

# Para introducir estos parametros en el design.fsf ....hacerlo con el vim, como esta puesto en el codigo de arriba
# Lo que pasa que habria que poner el texto a cambiar de forma exacta

# Cuidar variables locales y globales!


