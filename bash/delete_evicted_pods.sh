#/bin/bash!

kubectl get pods -n cxb-obsicp-pro |awk '{ print $1}' > evicted_pods.txt
cat evicted_pods | while read var1;do
   #echo "$var1"
   kubectl delete pod -n cxb-obsicp-pro $var1
done
