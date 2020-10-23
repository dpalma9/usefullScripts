#/bin/bash!

kubectl get pods -n my-namespace |awk '{ print $1}' > evicted_pods.txt
while read var;do
   #echo "$var1"
   kubectl delete pod -n my-namespace $var1
done < evicted_pods.txt
