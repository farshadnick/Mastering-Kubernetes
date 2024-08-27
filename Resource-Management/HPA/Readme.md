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

ab -n 90000 -c 10 http://nginx-service.default.svc.cluster.local/
```

# 4- Verify scalign
```
kubectl get hpa 
```
