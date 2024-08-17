## Here is docker-compose which need to be turned to kubernetes manifest
```
services:
  redis-leader:
    container_name: redis-leader
    image: redis
    ports:
      - "6379"

  redis-replica:
    container_name: redis-replica
    image: redis
    ports:
      - "6379"
    command: redis-server --replicaof redis-leader 6379 --dir /tmp

  web:
    container_name: web
    image: quay.io/kompose/web
    ports:
      - "8080:8080"
    environment:
      - GET_HOSTS_FROM=dns
    labels:
      kompose.service.type: LoadBalancer

```
## Install Kompose
```
curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose
```
## Covert to k8s manifest
```
kompose convert
```
```
INFO Kubernetes file "redis-leader-service.yaml" created
INFO Kubernetes file "redis-replica-service.yaml" created
INFO Kubernetes file "web-tcp-service.yaml" created
INFO Kubernetes file "redis-leader-deployment.yaml" created
INFO Kubernetes file "redis-replica-deployment.yaml" created
INFO Kubernetes file "web-deployment.yaml" created
```

```
 kubectl apply -f web-tcp-service.yaml,redis-leader-service.yaml,redis-replica-service.yaml,web-deployment.yaml,redis-leader-deployment.yaml,redis-replica-deployment.yaml
```
