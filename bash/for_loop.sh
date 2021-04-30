#/bin/bash!

for ip in $(cat myfile.txt);do echo $ip; ssh $ip 'find /var/lib/containers -mmin +60 -type f -name "*.log*" -exec rm -f {} \;'; done 
