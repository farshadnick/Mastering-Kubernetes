```
apt update && apt install nfs-server 
mkdir /exports
echo "/exports *(rw,sync,no_subtree_check)" > /etc/exports 
```
