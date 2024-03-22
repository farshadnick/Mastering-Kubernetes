Creat a secret name backend-user with key backend-username and value backend-admin
this way 
```
kubectl create secret generic backend-user --from-literal=backend-username='backend-admin'
```
OR Create it as a manifest
```
apiVersion: v1
kind: Secret
metadata:
  name: backend-user
type: Opaque
data:
  backend-username: YmFja2VuZC1hZG1pbg==   # base64-encoded value of 'backend-admin'
```
and apply nginx
```
kubectl apply  nginx-secret-env.yml
```
Check the env it should have show backend-admin
```
kubectl exec -i -t env-single-secret -- /bin/sh -c 'echo $SECRET_USERNAME'
```
![Uploading image.png…]()
