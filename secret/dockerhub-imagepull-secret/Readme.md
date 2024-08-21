## 1- Create imagepullsecret 
Create username password based on your dockerhub user pass in this structure :
```
kubectl create secret docker-registry my-registry-secret \
  --docker-server=https://index.docker.io/v1/ \
  --docker-username=mrnickfetrat@gmail.com \
  --docker-password=PASSS \
  --docker-email=mrnickfetrat@gmail.com

```
## 1-1 For cheking you secret 
```
kubectl get secrets my-registry-secret -o yaml
```
## 2- create your manifest based on  private image that you have on dockerhub 
```
apiVersion: v1
kind: Pod
metadata:
  name: my-private-image-pod
spec:
  containers:
    - name: my-container
      image: farshadnikfetrat/hello-nodejs:5918f3e7
  imagePullSecrets:
    - name: my-registry-secret

```
