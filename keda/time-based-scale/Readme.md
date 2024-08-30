## 1- Install keda
```
kubectl apply   --force-conflicts  --server-side -f https://github.com/kedacore/keda/releases/download/v2.12.0/keda-2.12.0.yaml
kubectl get pods -n keda

```
      
## 2- Create an deployment that you want to scale
```
# nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80

```
## 3- Create object scale rule
```
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: time-based-scaler2
  namespace: default
spec:
  scaleTargetRef:
    name: nginx-deployment
    kind: Deployment
    apiVersion: apps/v1
  minReplicaCount: 1
  maxReplicaCount: 3
  cooldownPeriod: 30
  triggers:
  - type: cron
    metadata:
      # Required
      timezone: Asia/Tehran  # The acceptable values would be a value from the IANA Time Zone Database.
      start: 6 1 * * *        # At 6:00 AM
      end: 20 1 * * *         # At 8:00 PM
      desiredReplicas: "3"

```

