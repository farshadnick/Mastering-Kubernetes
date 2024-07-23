# Apply all manifests 
 our Desired pod should be able to get pods in default Namespace
 
```
kubectl apply -f ./*
kubectl exec pod-checker -- kubectl get pods
```
<img width="1323" alt="image" src="https://github.com/user-attachments/assets/1e52fc53-a168-48f9-aec6-812fd999642a">

```
+--------------------+
|                    |
|  Service Account   |
|  pod-reader-sa     |
|  Namespace: default|
|                    |
+----------+---------+
           |
           |
           v
+------------------------------------+
|                                    |
|       Role                         |
|    pod-reader                      |
|    rules:                          |
|    - apiGroups: [""]               |
|    resources: ["pods"]             |
|    verbs: ["get", "watch", "list"] |
|    Namespace: default              |
|                                    |
+----------+-------------------------+
           |
           |
           v
+-------------------------------+
|                                |
|    RoleBinding                 |
|    read-pods                   |
|  Namespace: default            |
|   - kind: ServiceAccount       |
|    name: pod-reader-sa         |
|    namespace: default          |
|    roleRef:                    |
|    kind: Role                  |
|    name: pod-reader            |
|                                |
+----------+---------------------+
           |
           |
           v
+--------------------+
|                    |
|        Pod         |
|   pod-checker      |
|  Namespace: default|
| Service Account:   |
|  pod-reader-sa     |
|                    |
+--------------------+

Relationship:
- Service Account is bound to the Role via RoleBinding.
- Pod uses the Service Account to get permissions defined by the Role.

```
