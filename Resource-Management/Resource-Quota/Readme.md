You are managing a Kubernetes namespace called prod-namespace, and you want to enforce strict resource usage limits to prevent the namespace from consuming too many cluster resources. Specifically, you want to:
- Limit the total CPU requests in the namespace to 10 CPUs
- Limit the total memory requests in the namespace to 20Gi.
- Restrict the total number of Pods in the namespace to 50.
- Limit the number of Persistent Volume Claims (PVCs) to 10.



  kubectl get resourcequota resource-quota --namespace=prod-namespace --output=yaml
