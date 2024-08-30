

## install vpa 
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-v1-crd-gen.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/vpa-release-1.0/vertical-pod-autoscaler/deploy/vpa-rbac.yaml
```
```
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-vpa.yaml

kubectl describe vpa nginx-vpa

```
