## 1- Install nfs server on a node 
```
apt update && apt install nfs-server 
mkdir /exports
echo "/exports *(rw,sync,no_subtree_check)" > /etc/exports 
```
## 2- install nfs-common on all workers in order to connect to nfs server
```
apt update && apt install nfs-common
```

## 3- Create PV and PVC
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteOnce
  nfs:
    server: 192.168.5.242
    path: "/exports"
  mountOptions:
    - nfsvers=4.2
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ""
  resources:
    requests:
      storage: 1Mi
  volumeName: nfs

 ```

## 4- Create pod that using pvc
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-busybox
spec:
  replicas: 3
  selector:
    matchLabels:
      name: nfs-busybox
  template:
    metadata:
      labels:
        name: nfs-busybox
    spec:
      containers:
      - image: busybox
        command:
          - sh
          - -c
          - 'while true; do date >> /mnt/index.html; hostname >> /mnt/index.html; sleep $(($RANDOM % 5 + 5)); done'
        imagePullPolicy: IfNotPresent
        name: busybox
        volumeMounts:
          # name must match the volume name below
          - name: nfs
            mountPath: "/mnt"
      volumes:
      - name: nfs
        persistentVolumeClaim:
          claimName: nfs
```

