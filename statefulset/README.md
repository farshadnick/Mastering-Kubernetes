
# Create Persistent Volume (if you dont have )
create pv and make it default pv  in our scenario Our storage is Localpath
```
kubectl apply pv.yml 
```
## Make it Default pv
```
kubectl patch storageclass my-local-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

# bring up your statefulset
```
kubectl apply -f statefulset.yml
```

# verify your PV and PVC

```
kubectl get pv 
kubectl get pvc
```
