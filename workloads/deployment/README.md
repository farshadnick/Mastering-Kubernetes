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
Create Nodeport Service with fixed port 3007 
```
apiVersion: v1
kind: Service
metadata:
  name: nginx-svc                                    # create a service with "nginx" name
  labels:
    app: webserver
spec:
  type: NodePort
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - port: 80
      # By default and for convenience, the `targetPort` is set to
      # the same value as the `port` field.
      targetPort: 80
      # Optional field
      # By default and for convenience, the Kubernetes control plane
      # will allocate a port from a range (default: 30000-32767)
      nodePort: 30007
  selector:                                       # headless service provides to reach pod with podName.serviceName
    app: webserver

```
and Then you can see the list of version that your deployment has and revert your change to previoius version
```
kubectl rollout history deployment/nginx-deployment

kubectl rollout undo deployment/nginx-deployment --to-revision=2
```
