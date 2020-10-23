#/bin/bash!

kubectl get pods -n my-namespace |awk '{ print $1}' > evicted_pods.txt
cat evicted_pods | while read var1;do
   #echo "$var1"
   kubectl delete pod -n my-namespace $var1
done
