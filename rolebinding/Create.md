```
kubectl create rolebinding farshad-admin  --clusterrole=admin --user=farshad
```

```
kubectl get RoleBinding  -o yaml
```

# output would be something like this
```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: "2023-01-15T14:54:47Z"
  name: farshad-admin
  namespace: default
  resourceVersion: "22145"
  uid: 6bf97d50-fa9f-4437-b2d0-e1aa1dbe22ae
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: farshad

```
