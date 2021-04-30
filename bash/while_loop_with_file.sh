#/bin/bash!

# Para que el ssh funcione y siga leyendo del fichero nodes.txt, es necesario hacer el redirect a nul
# Mirar: https://unix.stackexchange.com/questions/107800/using-while-loop-to-ssh-to-multiple-servers

while read line;do
  echo "Este node $line"
  ssh $line 'ls -lrt /var/lib/docker' < /dev/null
done < myfile.txt
