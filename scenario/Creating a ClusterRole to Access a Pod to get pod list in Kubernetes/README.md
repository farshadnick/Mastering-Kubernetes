
## Create a ClusterRole
```
kubectl create clusterrole pv-reader --verb=get,list --resource=pod

```

##  Create Cluster Rolbinding

```
kubectl create ns packops 
kubectl create clusterrolebinding pv-test --clusterrole=pv-reader --serviceaccount=packops:default
```
## Create Pod to Verify it 
```
apiVersion: v1
kind: Pod
metadata:
  name: curlpod
  namespace: packops
spec:
  containers:
  - image: curlimages/curl
    command: ["sleep", "9999999"]
    name: main
  - image: linuxacademycontent/kubectl-proxy
    name: proxy
  restartPolicy: Always


```
```
kubectl exec -it curlpod -n packops -- sh
curl localhost:8001/api/v1/namespaces/web/pods
```
![image](https://github.com/farshadnick/kubernetes-tutorial/assets/88557305/e7230123-5426-44c9-8404-4a6bec8636a2)

