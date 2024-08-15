
![Untitled Diagram-Page-5 drawio](https://github.com/user-attachments/assets/1a19fad6-1226-40d5-b8df-7f7863190517)

## Create SA and namespace`
```
kubectl create namespace packops
kubectl create namespace web

kubectl create serviceaccount sa-read -n packops
```
## Create a ClusterRole
```
kubectl create clusterrole pod-reader --verb=get,list --resource=pod

```

##  Create Cluster Rolbinding

```
kubectl create clusterrolebinding pod-crb --clusterrole=pod-reader --serviceaccount=packops:sa-read
```
## Create Pod to Verify it 
```
apiVersion: v1
kind: Pod
metadata:
  name: kubectlpod
  namespace: packops
spec:
  serviceAccountName: sa-read
  containers:
  - name: kubectl
    image: bitnami/kubectl:latest
    command: ["sleep", "9999999"]
  restartPolicy: Always


```
# Create a simple nginx in web namespace
```
kubectl run nginx --image=nginx --namespace=web

```
```
kubectl exec -it kubectlpod -n packops -- sh
kubectl get pods -n web
```
![image](https://github.com/user-attachments/assets/40234924-7651-4bbc-80a8-ac7c12a31bba)



