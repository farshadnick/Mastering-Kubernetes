
## Here is a sample YAML file for a static Pod named nginx:
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: default
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80

```
## Place the YAML file in the kubelet manifest directory
The default location for static Pods is usually /etc/kubernetes/manifests/ on the node where the kubelet is running.
```
sudo mv nginx.yaml /etc/kubernetes/manifests/
```

## Key Characteristics of Static Pods:

    Not Managed by the Scheduler: The scheduler does not handle static Pods. Instead, they are placed directly by the kubelet on the node where the manifest file resides.
    Defined Locally: Static Pods are defined by placing their YAML manifest files in a specific directory on the node (usually /etc/kubernetes/manifests/).
    No API Server Involvement: Although the static Pod’s status can be viewed using kubectl, it is not part of the usual control plane workflows (like Deployments, ReplicaSets).
    Managed by the Kubelet: The kubelet continuously monitors the manifest directory and manages the lifecycle of static Pods.
