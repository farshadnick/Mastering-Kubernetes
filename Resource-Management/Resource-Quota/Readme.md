You want to manage resource usage in the prod-namespace by setting both requests and limits. Specifically, you will:

    Limit the total CPU requests in the namespace to 10 CPUs.
    Limit the total memory requests in the namespace to 20Gi.
    Cap the total CPU limits in the namespace to 15 CPUs.
    Cap the total memory limits in the namespace to 30Gi.

```
  kubectl get resourcequota resource-quota --namespace=prod-namespace --output=yaml
```
