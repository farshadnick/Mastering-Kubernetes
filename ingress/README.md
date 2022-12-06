# install ingress with Hostmode (listen on port 80 )
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
