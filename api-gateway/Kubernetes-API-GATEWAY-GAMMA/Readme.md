# Cilium Gateway API on Baremetal Kubernetes

Production-ready guide for installing and testing Gateway API with Cilium on Baremetal / On-Prem Kubernetes using L2 Announcements.

---

# Architecture

```text
Client
   ↓
L2 Announcement (ARP/NDP)
   ↓
LoadBalancer IP
   ↓
Cilium Gateway API
   ↓
Envoy
   ↓
HTTPRoute
   ↓
Kubernetes Service
   ↓
Pods
```

---

# Features

* Cilium Gateway API
* Envoy Integration
* Gateway API CRDs
* Baremetal LoadBalancer Support
* L2 Announcements
* eBPF LoadBalancing
* Host-based Routing
* Path-based Routing
* Canary Routing (90/10)
* kube-proxy replacement

---

# Requirements

* Kubernetes Cluster
* Cilium >= 1.16
* Helm
* Baremetal or On-Prem Network
* Layer2 connectivity between nodes

---

# Enable Gateway API in Cilium

Add the following values into your `values.yaml`:

```yaml
kubeProxyReplacement: true

l2announcements:
  enabled: true

externalIPs:
  enabled: true

# Gateway API

gatewayAPI:
  enabled: true

# Envoy

envoy:
  enabled: true
```

---

# Example Full values.yaml

```yaml
global:
  registey: kube.aradarpanet.ir

kubeProxyReplacement: true

l2announcements:
  enabled: true

externalIPs:
  enabled: true

k8sServiceHost: 192.168.80.60
k8sServicePort: 6443

gatewayAPI:
  enabled: true

image:
  repository: kube.aradarpanet.ir/cilium/cilium
  tag: v1.19.3

envoy:
  enabled: true
  image:
    repository: kube.aradarpanet.ir/cilium/cilium-envoy
    tag: v1.34.10-1762597008-ff7ae7d623be00078865cff1b0672cc5d9bfc6d5
```

---

# Install / Upgrade Cilium

```bash
helm upgrade --install cilium arad-cilium/cilium \
  --namespace kube-system \
  --values values.yaml
```

---

# Install Gateway API CRDs

Download the standard Gateway API CRDs:

```bash
wget https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml
```

Install:

```bash
kubectl apply -f standard-install.yaml
```

---

# Verify GatewayClass

```bash
kubectl get gatewayclass
```

Expected output:

```text
NAME     CONTROLLER                     ACCEPTED
cilium   io.cilium/gateway-controller   True
```

---

# Create Shared Gateway

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: shared-gateway
spec:
  gatewayClassName: cilium
  listeners:
    - name: http
      protocol: HTTP
      port: 80
      allowedRoutes:
        namespaces:
          from: All
```

Apply:

```bash
kubectl apply -f gateway.yaml
```

---

# Verify Gateway Service

```bash
kubectl get svc
```

Expected:

```text
cilium-gateway-shared-gateway   LoadBalancer   192.168.80.80
```

---

# Why L2 Announcements Are Required

Gateway API itself does NOT provide external LoadBalancer functionality.

On Baremetal:

* Kubernetes creates a `Service type=LoadBalancer`
* Cilium assigns an IP
* L2 Announcements advertise the IP using ARP/NDP

Without L2 Announcements:

* External IP will not respond
* `curl` requests will timeout

---

# Busybox Test Application

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox
  template:
    metadata:
      labels:
        app: busybox
    spec:
      containers:
        - name: busybox
          image: kube.aradarpanet.ir/library/busybox:latest
          command:
            - sh
            - -c
            - |
              while true; do
                echo -e "HTTP/1.1 200 OK\r\n\r\nhello from cilium gateway api" | nc -l -p 8080;
              done
          ports:
            - containerPort: 8080

---
apiVersion: v1
kind: Service
metadata:
  name: busybox-service
spec:
  selector:
    app: busybox
  ports:
    - port: 80
      targetPort: 8080
```

---

# HTTPRoute Example

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: busybox-route
spec:
  parentRefs:
    - name: shared-gateway
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
        - name: busybox-service
          port: 80
```

Apply:

```bash
kubectl apply -f route.yaml
```

---

# Test Gateway API

Get Gateway LoadBalancer IP:

```bash
kubectl get svc
```
  
Test:

```bash
curl http://192.168.80.80
```

Expected:

```text
hello from cilium gateway api
```

---

# Host-Based Routing Example

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: host-route
spec:
  parentRefs:
    - name: shared-gateway
  hostnames:
    - test.local
  rules:
    - backendRefs:
        - name: busybox-service
          port: 80
```

Test:

```bash
curl -H "Host: test.local" http://192.168.80.80
```

---

# Path-Based Routing Example

```yaml
rules:
  - matches:
      - path:
          type: PathPrefix
          value: /api
    backendRefs:
      - name: api-service
        port: 80

  - matches:
      - path:
          type: PathPrefix
          value: /web
    backendRefs:
      - name: web-service
        port: 80
```

---

# Canary Deployment (90/10)

## Important

Weighted routing requires different Services.

Incorrect:

```yaml
backendRefs:
  - name: same-service
    weight: 90
  - name: same-service
    weight: 10
```

Correct:

```yaml
backendRefs:
  - name: svc-v1
    weight: 90
  - name: svc-v2
    weight: 10
```

---

# Canary Example

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: canary-route
spec:
  parentRefs:
    - name: shared-gateway
  rules:
    - backendRefs:
        - name: svc-v1
          port: 80
          weight: 90
        - name: svc-v2
          port: 80
          weight: 10
```

Test:

```bash
for i in {1..20}; do curl -s http://192.168.80.80; echo; done
```

---

# Shared vs Dedicated LoadBalancer

## Dedicated LB

Each Gateway receives its own LoadBalancer IP.

```text
Gateway A -> LB/IP A
Gateway B -> LB/IP B
```

Advantages:

* Isolation
* Independent lifecycle
* Separate TLS/auth policies
* Better tenant separation

---

## Shared LB

Multiple routes share the same Gateway and IP.

```text
shared-gateway
 ├── app1-route
 ├── app2-route
 └── api-route
```

Advantages:

* Less IP consumption
* Easier management
* Better resource efficiency

---

# Troubleshooting

## Check GatewayClass

```bash
kubectl get gatewayclass
```

---

## Check Gateway

```bash
kubectl get gateway
kubectl describe gateway shared-gateway
```

---

## Check HTTPRoute

```bash
kubectl get httproute
kubectl describe httproute
```

Expected:

```text
Accepted: True
ResolvedRefs: True
```

---

## Check Envoy Config

```bash
kubectl get ciliumenvoyconfig
```

---

## Check Services

```bash
kubectl get svc -A
```

---

## Check Pods

```bash
kubectl get po -A
```

---

# Production Recommendations

Recommended architecture:

```text
Internet
   ↓
Shared Gateway
   ↓
Multiple HTTPRoutes
   ↓
Applications
```

Use separate namespaces:

```text
networking/
  shared-gateway

team-a/
  routes

team-b/
  routes
```

---

# Useful Features to Explore Next

* TLS termination
* Wildcard certificates
* Header-based routing
* Cookie-based canary
* Traffic mirroring
* gRPC routing
* WebSocket support
* Rate limiting
* External authentication
* BGP Advertisement

---

# References

* Cilium Gateway API
* Kubernetes Gateway API
* Envoy Proxy
* Cilium L2 Announcements

---

# Final Notes

This setup provides:

* Baremetal LoadBalancer support
* eBPF accelerated networking
* Envoy-based Gateway API
* Production-grade HTTP routing
* Modern Kubernetes traffic management

without requiring:

* MetalLB
* ingress-nginx
* kube-proxy
