# 1- Install api gateway first
```
kubectl apply -f experimental-install.yaml
```

# 2- Install all required CRDs
```
kubectl apply -f  all-cilium-crd.yaml
```

# 3- add arad helm chart 
```
helm repo add arad https://registry.aradarpanet.ir/repository/Helm-Hosted/
helm repo update
helm install  cilium arad/cilium   -n kube-system   --create-namespace   -f values2.yml
```
