## Prequsit 
Install metric server with insecure tls mode
```
wget  https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
vim components.yaml

```
- --kubelet-insecure-tls in args
```
- --kubelet-insecure-tls 
```
![image](https://github.com/user-attachments/assets/3bcd1e27-02af-4e9f-b371-1a68ba1e8287)

```
kubectl apply -f components.yaml
kubectl get pods -n kube-system | grep metric

kubectl top pods
kubectl top nodes

```

## 1- Create a deployment with resource limit
```
kubectl apply -f nginx-deployment.yaml
```

## 2- Create HPA Rule for it 
```
kubectl apply -f hpa.yml
kubectl get hpa
```
```
--cpu-percent=50: Target average CPU utilization across all pods should be 50%.
--min=1: Minimum number of pod replicas is 1.
--max=10: Maximum number of pod replicas is 10.
```
# 3- Generate Load 
```
apt install apache2-utils -y

ab -n 190000 -c 1000 http://nginx-service/
```

# 4- Verify Scaling
```
kubectl get hpa 
```
