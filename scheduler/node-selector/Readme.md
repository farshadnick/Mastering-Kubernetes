1. Label your node
First, you label the node where you want the pod to be scheduled.
```
kubectl label nodes <node-name> disktype=ssd
```
2. Pod Specification with Node Selector
Next, you define a pod that will use this node selector:
```
apiVersion: v1
kind: Pod
metadata:
  name: selector
spec:
  containers:
  - name: my-container
    image: nginx
  nodeSelector:
    disktype: ssd


```
