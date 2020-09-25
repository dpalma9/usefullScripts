#/bin/bash!

cat template.txt | awk -F ";" '{print $1,$2,$3}' | while read var1 var2 var3;do
   echo "$var1|$var2|$var3"
done
