# Lable a Kubernetes Node 
1- kubectl get nodes

```
worker0   Ready     <none>   1d      v1.13.0        ...,kubernetes.io/hostname=worker0
worker1   Ready     <none>   1d      v1.13.0        ...,kubernetes.io/hostname=worker1
worker2   Ready     <none>   1d      v1.13.0        ...,kubernetes.io/hostname=worker2
```

2- kubectl label nodes <your-node-name> nodename=bi-team
  
3- kubectl apply -f node-affinity.yml
