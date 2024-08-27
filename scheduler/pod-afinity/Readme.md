## Pod Affinity

Pod Affinity allows you to schedule a pod close to other pods that match specific criteria, usually based on labels. This can be useful for workloads that need to be co-located for performance reasons.
Types of Pod Affinity:

    RequiredDuringSchedulingIgnoredDuringExecution: The pod must be scheduled on a node that has the specified other pods running.

    PreferredDuringSchedulingIgnoredDuringExecution: The scheduler tries to place the pod on a node with the specified other pods, but it is not a strict requirement.
```
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        labelSelector:
          matchExpressions:
          - key: app
            operator: In
            values:
            - frontend
        topologyKey: kubernetes.io/hostname
  containers:
  - name: nginx
    image: nginx
```
