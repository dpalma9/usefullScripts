#/bin/bash!

# VARS
POD_FILE="pods_podridos.txt"

# Get all corrupted pods
kubectl get pods -A | grep -v "Running\|Completed" > $POD_FILE
# Remove first line with column name
sed -i '1d' $POD_FILE

cat $POD_FILE | awk '{print $1,$2}' | while read var1 var2;do
   kubectl delete pod -n $var1 $var2
done

rm $POD_FILE