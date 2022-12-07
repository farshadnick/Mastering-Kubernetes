# install ingress with Hostmode (listen on port 80 )
for accessing on port 80 we need to change deployment to host mode network 
i Add this cahnge but for Your Information i just added  below hostnetowrk in deploymnet section in manifest ingress-host-mode.yml 

```
template:
  spec:
    hostNetwork: true

```

```
kubectl apply -f ingress-host-mode.yml
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
```
# Scale up ingress controler to 3 (in our scenario we have 3 node)
```
kubectl scale  deployments ingress-nginx-controller -n ingress-nginx --replicas 3

```

# apply simple app that listen on 5678  (apple.packops.local)
kubectl -f simple-app-ingress.yml




# Set host  apple.packops.local tp kubernetes ip 
