# install Istio First 
```
# Install istio api crd
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
{ kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.1.0" | kubectl apply -f -; }

curl -L https://istio.io/downloadIstio | sh -
istioctl install --set profile=default


```
### You should enable istio injector sidecar in order to Monitor Pods traffik
```
kubectl label namespace <your-namespace> istio-injection=enabled

```
### OR add ``istio-injection: enabled`` in manifest

```
metadata:
  labels:
    istio-injection: enabled
```
# Deploy virtual service and application
```
kubectl apply -f Virtualservice.yml
kubectl apply -f deployment.yml
```

# Curl with Host Header to isiot gateway ingress

```
kubectl get svc -n istio-system
curl    -H "Host: app1.packops.local" http://10.233.56.67

for i in {1..1000}; do    curl -H "Host: app1.packops.local" http://10.233.56.67; done

```

<img width="1442" alt="image" src="https://github.com/user-attachments/assets/08bd8da2-e119-45cc-84e2-78968f9ea7ed">
