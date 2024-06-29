## Creating a Pod
To create a Pod, you typically use a YAML file. Here's an example of a simple Pod definition:
```
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    ports:
    - containerPort: 80
```

## Create the Pod using kubectl apply:
```
kubectl apply -f nginx-pod.yaml
```

## Viewing Pods
List all Pods in the default namespace:
```
kubectl get pods
```

## List all Pods in all namespaces:
```
kubectl get pods --all-namespaces
```
## View detailed information about a specific Pod:

```
kubectl describe pod my-pod
```


## Running a Pod
You can also run a Pod directly using the kubectl run command:

```
kubectl run my-pod --image=nginx --port=80
```


## Scaling a Deployment
First, create a Deployment using a YAML file:
```
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx
        ports:
        - containerPort: 80

```

Create the Deployment using kubectl apply:

```
kubectl apply -f deployment.yaml
```

Scale the Deployment:
```
kubectl scale deployment my-deployment --replicas=5
```

Updating a Deployment

Set a new image for a Deployment's container:

```
kubectl set image deployment/my-deployment my-container=nginx:1.16.1
```

Certainly! Below are some common kubectl commands to run, scale, and manage Pods along with other useful operations you can perform with kubectl.
Creating a Pod

To create a Pod, you typically use a YAML file. Here's an example of a simple Pod definition:

```
#pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    ports:
    - containerPort: 80
```
## Create the Pod using kubectl apply:
```
kubectl apply -f pod.yaml
```
## Viewing Pods
List all Pods in the default namespace:
```
kubectl get pods
```

## List all Pods in all namespaces:
```
kubectl get pods --all-namespaces
```

## View detailed information about a specific Pod:
```
kubectl describe pod my-pod
```
## Running a Pod
You can also run a Pod directly using the kubectl run command:
```
kubectl run my-pod --image=nginx --port=80
```

## Scaling a Deployment
First, create a Deployment using a YAML file:
```
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx
        ports:
        - containerPort: 80
```
## Create the Deployment using kubectl apply:
```
kubectl apply -f deployment.yaml
```
## Scale the Deployment:
```
kubectl scale deployment my-deployment --replicas=5
```

## Updating a Deployment
Set a new image for a Deployment's container:
```
kubectl set image deployment/my-deployment my-container=nginx:1.16.1
```
## Rolling Back a Deployment
Roll back to the previous revision:

```
kubectl rollout undo deployment/my-deployment
```

## Viewing Deployment Status
Check the rollout status:
```
kubectl rollout status deployment/my-deployment
```
## Executing a Command in a Pod
```
kubectl exec -it my-pod -- /bin/bash
```

## Port Forwarding
Forward a local port to a port on a Pod:
```
kubectl port-forward pod/my-pod 8080:80
```




