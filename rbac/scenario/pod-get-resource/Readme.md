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
+--------------------+
|                    |
|    RoleBinding     |
|    read-pods       |
|  Namespace: default|
|                    |
+----------+---------+
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
