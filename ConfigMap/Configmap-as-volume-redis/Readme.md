```
kubectl apply -f redis-manifest-with-cm.yml
kubectl get cm shared-packops-redis-config -o yaml
kubectl get pods
kubectl exec -it shared-packops-redis-7cddbbf994-k5szl -- bash
redis-cli
```
```
cat /redis-master/redis.conf
auth PASSWORD1234P
get keys 
```
