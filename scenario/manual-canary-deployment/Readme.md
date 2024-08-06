
![image](https://github.com/user-attachments/assets/78405769-5f9e-41f8-92ec-ad79e5a07d11)

kubectl apply -f  nginx-canary.yml
kubectl apply -f  nginx-stable.yml
kubectl apply -f  nginx-service.yml
kubectl apply -f  nginx-configmap-canary.yml
kubectl apply -f  nginx-configmap-stable.yml


```
kubectl get svc 
```

```
for i in {1..30}; do curl -s http://10.233.57.87 && echo ""; sleep 1; done
```

![image](https://github.com/user-attachments/assets/a21f2de2-2012-4f2e-8517-c4495c2d8b8d)
