```plaintext
+---------------------------+
|       Kubernetes          |
|         Cluster           |
+---------------------------+
          |
          v
+---------------------------+
| Namespace: default        |
+---------------------------+
          |
          v
+---------------------------+      +---------------------------+
| ServiceAccount:           |      | Role: pod-reader          |
| pod-reader-sa             |      | - Resources: pods         |
|                           |      | - Verbs: get, watch, list |
+---------------------------+      +---------------------------+
          |                                   |
          |                                   |
          v                                   v
+---------------------------+      +---------------------------+
| RoleBinding:              |<-----| Bind Role: pod-reader     |
| read-pods                 |      | to ServiceAccount:        |
| - ServiceAccount:         |      | pod-reader-sa             |
|   pod-reader-sa           |      +---------------------------+
| - Role: pod-reader        |
+---------------------------+
          |
          v
+---------------------------+
| Pod: pod-checker          |
| - ServiceAccount:         |
|   pod-reader-sa           |
| - Container:              |
|   kubectl-container       |
|   Image: bitnami/kubectl  |
+---------------------------+
