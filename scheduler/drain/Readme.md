Cordoning the Node: Prevents new pods from being scheduled on the node.
```
kubectl cordon <node-name>
```
Draining the Node: Evicts all the pods while respecting the configurations.

```
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```
Perform Maintenance: After draining, perform any maintenance needed on the node.

Uncordon the Node (if needed): Allow new pods to be scheduled again.

```
kubectl uncordon <node-name>
```
