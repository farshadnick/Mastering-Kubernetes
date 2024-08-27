```
wget  https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
vim components.yaml
```

add `` - --kubelet-insecure-tls `` in args

![image](https://github.com/user-attachments/assets/816f8d45-74a2-4bd1-bcbe-157bab4c7f3c)

```
kubectl apply -f components.yaml
```
```
kubectl top pods
kubectl top nodes
```
