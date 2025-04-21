## Bonds
for node in $(oc get no --no-headers | awk '{print $1}'); do echo $node; ifaces=$(ssh core@$node cat /proc/net/bonding/bond0 | grep "Slave Interface" | wc -l); if [ $ifaces -lt "2" ]; then echo "ERROR!"; else ssh core@$node cat /proc/net/bonding/bond0 | grep Unknown; fi; done
