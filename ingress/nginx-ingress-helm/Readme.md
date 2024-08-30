## 1- install helm first
```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
## 2- add nginx repo
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

## there are 2 ways for bringing ingress controller up Deployment and deamon-set
## 3- install nginx deployment with replica (method 1)
```
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.replicaCount=2 \
  --set controller.nodeSelector."kubernetes\.io/os"=linux \
  --set controller.hostNetwork=true \
  --set controller.service.type=ClusterIP \
  --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
  --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
  --set controller.service.enableHttp=false \
  --set controller.hostPort.enabled=true \
  --set controller.hostPort.ports.http=80 \
  --set controller.hostPort.ports.https=443 \
  --set controller.ingressClassResource.name=nginx \
  --set controller.ingressClassResource.enabled=true \
  --set controller.ingressClass=nginx \
  --create-namespace
```

## 3- install nginx daemon-set with replica (method 2)
```
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.kind=DaemonSet \
  --set controller.daemonset.useHostPort=true \
  --set controller.hostNetwork=true \
  --set controller.nodeSelector."kubernetes\.io/os"=linux \
  --set controller.service.type=ClusterIP \
  --set controller.ingressClassResource.enabled=true \
  --set controller.ingressClassResource.name=nginx \
  --set controller.ingressClass=nginx \
  --set controller.hostPort.enabled=true \
  --set controller.hostPort.ports.http=80 \
  --set controller.hostPort.ports.https=443 \
  --create-namespace

```
## Apply sample deployment with service 
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
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
        image: nginx:1.19
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx
spec:
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

---
# ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  namespace: default
  annotations:
spec:
  ingressClassName: nginx  # <-- Add this line
  rules:
  - host: packops.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-service
            port:
              number: 80

```

##  Verify ingress
```
kubectl get ingress
kubectl logs -n ingress-nginx nginx-ingress-ingress-nginx-controller-55ff6f779c-5tdvs
kubectl get pods -n ingress-nginx -o wide
```
## set custom header for check ingress
```
curl -H 'Host:packops.local' http://192.168.6.131
```
