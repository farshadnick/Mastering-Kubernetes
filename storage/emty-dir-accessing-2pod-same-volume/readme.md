```
kubectl apply -f ngnix-shared-volume.yml
kubectl exec -it two-containers -c nginx-container -- /bin/bash
curl localhost
```
![image](https://github.com/farshadnick/kubernetes-tutorial/assets/88557305/33a47951-809b-4b53-8c57-fe29ea5c631a)
