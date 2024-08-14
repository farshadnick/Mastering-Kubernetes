You are managing a Kubernetes namespace called dev-namespace, and you want to ensure that all containers in this namespace have appropriate resource limits and requests. Specifically, you want to:

- Set a minimum resource request of 100m CPU and 128Mi memory for every container.
- Set a maximum resource limit of 2 CPU and 1Gi memory for any container.
- Provide default values of 200m CPU and 256Mi memory if a container doesn't specify any resource requests or limits.

Apply the LimitRange:

Apply the LimitRange to your dev-namespace:
```
kubectl apply -f limitrange.yaml
```

Create a Pod without Resource Requests or Limits:

Now, create a Pod in the dev-namespace without specifying any resource requests or limits to see the default values being applied:
```
kubectl apply -f test-pod.yaml
```

Check the Applied Resource Requests and Limits:
```
kubectl get pod test-pod -n dev-namespace -o jsonpath='{.spec.containers[0].resources}'
```

Out out must be something like that : 
{"limits":{"cpu":"200m","memory":"256Mi"},"requests":{"cpu":"100m","memory":"128Mi"}}

Try to Create pod more than limitation :

```
kubectl apply -f test-pod-exceed.yaml
```

The Kubernetes API server will reject this Pod creation because it exceeds the limits set by the LimitRange.
