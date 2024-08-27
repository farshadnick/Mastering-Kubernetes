
# 1- Install longhorn
```
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace
```
# 2- Create pod PVC
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: longhorn-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: longhorn
```
# 3- Create deployment and Assign pod to pvc 
```
apiVersion: v1
kind: Pod
metadata:
  name: longhorn-demo-pod
spec:
  containers:
    - name: demo-container
      image: nginx
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: longhorn-storage
  volumes:
    - name: longhorn-storage
      persistentVolumeClaim:
        claimName: longhorn-pvc

```
