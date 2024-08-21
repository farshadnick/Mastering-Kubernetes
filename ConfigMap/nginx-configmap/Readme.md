## 1- Create configmap with your nginx default config 
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx
data:
  index.html: |
    <html>
    <head>
      <title>Hello, World</title>
    </head>
    <body>
      <h1>Hello, World from a ConfigMap!</h1>
    </body>
    </html>

```
## 2- Create deployment that Include configmap and map it to nginx
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
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
        volumeMounts:
        - name: nginx-files
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nginx-files
        configMap:
          name: nginx

---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80

```

![image](https://github.com/user-attachments/assets/a50096ee-dc3e-408a-aa0e-0339c40de5a0)
