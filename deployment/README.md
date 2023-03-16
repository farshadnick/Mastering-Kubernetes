# Create a Nginx Deployment with 3 Replicas
```
kubectl apply -f nginx-deployment.yml
```

# Rollout to previous version
Make a change to your manifest 
in these scenario im going to add  a label named test=a in my  manifest  it can be anything you want

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  strategy:
    type: Recreate
  revisionHistoryLimit: 100
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        test: a
        app: webserver
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```
and Then you can see the list of version that your deployment has and revert your change to previoius version
```
kubectl rollout history deployment/nginx-deployment

kubectl rollout undo deployment/nginx-deployment --to-revision=2
```
