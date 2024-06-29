```
apt update && apt install nfs-server 
echo "/exports *(rw,sync,no_subtree_check)" > /etc/exports 
```
