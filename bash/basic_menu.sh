#/bin/bash!

## FUNCIONES
opcion_1() {
  echo "Soy la funcion opcion_1"
}

opcion_2() {
  echo "Soy la funcion opcion_2"
}

## MAIN
echo ""
echo "# --Mi menu chuleta-- #"
echo ""
echo "1. Opcion 1."
echo "2. Opcion 2."
read -p "Elije una opcion: " OPTION

case "$OPTION" in
         1)
        echo "Has elegido opcion 1"
        opcion_1
         ;;

         2)
      	echo "Has elegido opcion 2"
        opcion_2
         ;;

         *)
                 echo "¡Opcion no valida!"
                 exit 1
         ;;

 esac
