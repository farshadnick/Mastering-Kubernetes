```
kubectl apply -f Pod-address.yml
```
```
 kubectl logs web-server-pod -c write-ip 
 ```
Wrote the Pod IP to ip.txt
```
 kubectl logs web-server-pod -c create-html
```
Created index.html with the Pod IP
```
kubectl port-forward pod/web-server-pod 8080:80
```

![image-68](https://github.com/farshadnick/kubernetes-tutorial/assets/88557305/15fa6e12-ba17-4ca0-80a3-6325d6c22435)
