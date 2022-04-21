#!/bin/bash
clear

# Funciones

# Funcion para reconocer si el primer caracter del campo id es una letra o un numero utiliza la vari$
# Hay que declarar la variable MUESTREOID=$(cat id$1) cuando se vaya a utilizar la funcion, ej:
#MUESTREOID=$(cat id$1)
#primercaracter
primerCaracter (){
MUESTREO=$(echo ${MUESTREOID:0:1})
case $MUESTREO in
  [0-9])
        echo "El primer caracter es un numero"
  ;;
  [a-z]|[A-Z])
        echo "El primer caracter es una letra"
  ;;
esac
}
###################

# Comprueba que se ha pasado el archivo a corregir como parametro
if [ -z "$1" ]
then
  echo 'Recuerda escribir el nombre del archivo y su extension al usar el script'
  echo 'E.j: ./format.sh archivoConvertir.csv'
  exit
else
  echo 'Archivo utilizado '$1
fi

# Crear fichero con cabecera
echo 'Label,Login,Password,Url,Comments' >> result$1

# Volcar los datos en una copia y eliminar la cabecera
cat $1 >> copia$1
sed -i -e "1d" copia$1

# Contar las lineas de copia
LINEASCOPIA=$(cat copia$1 | wc -l)
echo "El fichero tiene" $LINEASCOPIA "lineas"

for (( j=1;j<=$LINEASCOPIA;j++ ))
do
# Pasar los datos separados
STRING=$(head -n 1 copia$1)
echo $STRING | tr ";" "\n" >> datos$1

# Eliminar campo id

# Eliminar campo id
sed -i -e "1d" datos$1

# Pasar campo formato raw a resultado y eliminar las lineas que se han pasado
LAB=$(head -n 1 datos$1)
sed -i -e "1d" datos$1

#COMM=$(head -n 1 datos$1)
sed -i -e "1d" datos$1

PASS=$(head -n 1 datos$1)
sed -i -e "1d" datos$1

LOGI=$(head -n 1 datos$1)
sed -i -e "1d" datos$1

sed -i -e "1d" datos$1
sed -i -e "1d" datos$1

URL=$(head -n 1 datos$1)

LINESTRING="${LAB},${LOGI},${PASS},${URL},${COMM}"
echo $LINESTRING >> result$1
sed -i -e "1d" copia$1
truncate -s 0 datos$1
done

# Eliminar ficheros no necesarios
rm copia$1 datos$1

truncate -s 0 archivo.csv
