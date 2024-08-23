```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
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
        image: nginx:1.23.3
        ports:
        - containerPort: 80
        startupProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 5
          failureThreshold: 20
```

Image: The deployment uses the official nginx:1.23.3 image.

startupProbe:

    httpGet: The probe checks the root URL / of the nginx server on port 80.
    initialDelaySeconds: The probe waits 10 seconds before starting to allow time for nginx to initialize.
    periodSeconds: The probe runs every 5 seconds.
    failureThreshold: The probe will tolerate up to 20 failures (equivalent to 100 seconds) before considering the container to have failed and triggering a restart.
