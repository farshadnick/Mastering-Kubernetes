# How to use priority and preemption
## To use priority and preemption:
### 1-Add one or more PriorityClasses.
### 2-Create Pods withpriorityClassName set to one of the added PriorityClasses.

# PriorityClass 
A PriorityClass is a non-namespaced object that defines a mapping from a priority class name to the integer value of the priority (higher the value, the higher the priority)
In Kubernetes, the default priority for pods is zero if no PriorityClass
```
apiVersion: scheduling.k8s.io/v1beta1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000
globalDefault: false
description: This is a very high priority Pod class
```
# Assing PriorityClass to POD or deployment

```
# Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: random-generator-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: random-generator
  template:
    metadata:
      labels:
        app: random-generator
    spec:
      containers:
      - image: k8spatterns/random-generator:1.0
        name: random-generator
      priorityClassName: high-priority
```
# OR You Can Assign it to an Deployment
```
#POD 
apiVersion: v1
kind: Pod
metadata:
  name: random-generator
  labels:
    env: random-generator
spec:
  containers:
  - image: k8spatterns/random-generator:1.0
    name: random-generator
  priorityClassName: high-priority

```
