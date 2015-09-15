#!/bin/bash

rutal=$1
usuario=$2
maquina=$3
rutar=$4
if [ "$rutal" != "" ] && [ -n "$usuario" ] && [  "$maquina" != "" ] && [ -n "$rutar" ]
then
#echo "entradas bien"

	#Hacemos ping al servidor remoto para saber si está activo
	# -q quiet
	# -c numero de intentos, en este caso 1
	#lo guardamos en > /dev/null para que devuelva un valor 0 o 1
	# si funciona, hacemos la transferencia
	ping -q -c 1 $maquina > /dev/null
	if [ $? -eq 0  ]
	then
	echo Ping $maquina OK.
		#Existe el archivo?
		if [ -e $rutal ]
		then
			if [ -d $rutal  ]
			then
			echo Transfiriendo el directorio: $rutal
			scp -r $rutal $usuario@$maquina:$rutar
			return $?
			else
			echo Transfiriendo el archivo: $rutal
			scp  $rutal $usuario@$maquina:$rutar
			return $?
			fi
		else
		echo error: $rutal no existe.
		return 3
		#Fin Existe
		fi

	else
	echo error: $maquina no está disponible.
	return 2
	#Fin del ping
	fi

else
echo error: introduzca comando rutaLocal usuario IPmaquina rutaRemota.
return 1
fi
