
#!/bin/bash
clear

# FUNCIONES

# Funcion para reconocer si el primer caracter del campo id es una letra o un numero utiliza la vari$
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

# Crea los archivos de trabajo
cp $1 copia$1
touch analiza$1
touch datos$1

# Crea el archivo resultado con la cabecera apropiada
echo 'Label,Login,Password,Url,Comments' >> result$1

# Eliminar linea de encabezado en archivo copia
sed -i -e "1d" copia$1

# Obetener primera linea de copia y enviarla a archivo analiza
head -n 1 copia$1 >> analiza$1

# Funcion para separar los datos de la primera linea
STRING=$(cat analiza$1)
echo $STRING |tr ";" "\n" >> datos$1
sed -i '/^$/d' datos$1

# Traspaso de datos
head -n 1 datos$1 >> id$1
sed -i -e "1d" datos$1
ID=$(cat id$1)

head -n 1 datos$1 >> label$1
sed -i -e "1d" datos$1
LAB=$(cat label$1)

head -n 1 datos$1 >> login$1
sed -i -e "1d" datos$1
LOGI=$(cat login$1)

#LINESTRING="${LAB},${LOGI}"
echo $LINESTRING >>result$1

# Llamada a la funcion primerCaracter
MUESTREOID=$(cat id$1)
primerCaracter

#rm analiza$1 copia$1 datos$1
