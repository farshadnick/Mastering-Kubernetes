in this  Scenario we are going to Block all Trafic in

# Default Network Policy  to Block all incomming Trafic to namespace web-auth
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: web-auth
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```





# Network Policy for Permiting Auth-Client to Auth-Server

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: auth-server-ingress
  namespace: web-auth
spec:
  podSelector:
    matchLabels:
      app: auth-server
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          role: auth
      podSelector:
        matchLabels:
          app: auth-client
    ports:
    - protocol: TCP
      port: 80


```
