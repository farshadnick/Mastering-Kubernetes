## 1- Create Configmap which contains our config
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: simple-config
data:
  database_url: "mongodb://db1.example.net:27017"
  feature_flag: "true"
  log_level: "debug"

```

## 1-1 apply it 
```
kubectl apply -f configmap.yml
```
## 1-2 Check the Configmap
```
kubectl get cm
```

## 2- Create POD/Deployment to use configmap as env 

```
apiVersion: v1
kind: Pod
metadata:
  name: app-pod
spec:
  containers:
    - name: app-container
      image: nginx
      env:
        - name: DATABASE_URL
          valueFrom:
            configMapKeyRef:
              name: simple-config
              key: database_url
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: simple-config
              key: log_level
```
```
kubectl apply -f pod.yml
```
## 3- Exec in POD and check env 
```
kubectl exec -it app-pod -- bash
printenv  | grep DATABASE_URL
printenv  | grep LOG_LEVEL
```

