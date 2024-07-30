# Imperative Vs Declarative 

| Aspect               | Imperative Approach                               | Declarative Approach                                |
|----------------------|---------------------------------------------------|----------------------------------------------------|
| **Definition**       | Commands that directly make changes to the system | Configurations that define desired system state     |
| **Operation**        | Execute specific commands manually                | Apply configuration files to manage state           |
| **Command Examples** | `kubectl create`, `kubectl delete`                | `kubectl apply`, `kubectl delete -f`                |
| **State Management** | Manual tracking of state changes                  | Automatic state reconciliation by Kubernetes        |
| **Use Case**         | Quick, ad-hoc tasks and debugging                 | Managing complex, consistent, and repeatable deployments |
| **Workflow**         | Immediate execution                               | Configuration files managed over time               |
| **Pros**             | - Immediate feedback <br> - Simple for small tasks | - Ensures consistency <br> - Easier to automate and version control |
| **Cons**             | - Error-prone <br> - Less consistent and repeatable | - Steeper learning curve <br> - Less immediate control |
| **Examples**         | - `kubectl run nginx --image=nginx` <br> - `kubectl delete pod my-pod` | - `kubectl apply -f deployment.yaml` <br> - `kubectl apply -f service.yaml` |
| **Learning Curve**   | Lower                                             | Higher                                              |
| **Version Control**  | Less straightforward                             | Natural fit for version control systems (e.g., Git) |


# Kubectl Cheat Sheet

| **Command**                                   | **Description**                                            |
|-----------------------------------------------|------------------------------------------------------------|
| `kubectl version`                             | Display the Kubernetes version                             |
| `kubectl cluster-info`                        | Display cluster information                                |
| `kubectl get nodes`                           | List all nodes in the cluster                              |
| `kubectl describe node <node_name>`           | Display detailed information about a specific node         |
| `kubectl get pods`                            | List all Pods in the default namespace                     |
| `kubectl get pods --all-namespaces`           | List all Pods in all namespaces                            |
| `kubectl get pods -n <namespace>`             | List all Pods in a specific namespace                      |
| `kubectl describe pod <pod_name>`             | Display detailed information about a specific Pod          |
| `kubectl logs <pod_name>`                     | Print the logs for a container in a Pod                    |
| `kubectl exec -it <pod_name> -- /bin/bash`    | Execute a command in a container in a Pod                  |
| `kubectl get services`                        | List all Services in the default namespace                 |
| `kubectl get svc`                             | Shorthand for `kubectl get services`                       |
| `kubectl describe svc <service_name>`         | Display detailed information about a specific Service      |
| `kubectl get deployments`                     | List all Deployments in the default namespace              |
| `kubectl describe deployment <deployment_name>`| Display detailed information about a specific Deployment   |
| `kubectl get replicasets`                     | List all ReplicaSets in the default namespace              |
| `kubectl get rs`                              | Shorthand for `kubectl get replicasets`                    |
| `kubectl describe rs <replicaset_name>`       | Display detailed information about a specific ReplicaSet   |
| `kubectl get namespaces`                      | List all namespaces                                        |
| `kubectl get ns`                              | Shorthand for `kubectl get namespaces`                     |
| `kubectl create namespace <namespace_name>`   | Create a new namespace                                     |
| `kubectl delete namespace <namespace_name>`   | Delete a namespace                                         |
| `kubectl apply -f <file.yaml>`                | Apply a configuration to a resource by filename or stdin   |
| `kubectl create -f <file.yaml>`               | Create a resource from a file                              |
| `kubectl delete -f <file.yaml>`               | Delete a resource from a file                              |
| `kubectl edit <resource> <resource_name>`     | Edit a resource on the server                              |
| `kubectl scale --replicas=<count> deployment/<deployment_name>` | Scale a deployment to a specified number of replicas |
| `kubectl rollout status deployment/<deployment_name>` | Watch the rollout status of a deployment          |
| `kubectl rollout undo deployment/<deployment_name>` | Undo a deployment to a previous revision             |
| `kubectl get configmaps`                      | List all ConfigMaps in the default namespace                |
| `kubectl describe configmap <configmap_name>` | Display detailed information about a specific ConfigMap    |
| `kubectl get secrets`                         | List all Secrets in the default namespace                  |
| `kubectl describe secret <secret_name>`       | Display detailed information about a specific Secret       |
| `kubectl get pv`                              | List all PersistentVolumes                                 |
| `kubectl get pvc`                             | List all PersistentVolumeClaims in the default namespace   |
| `kubectl describe pvc <pvc_name>`             | Display detailed information about a specific PVC          |
| `kubectl get events`                          | List all events in the default namespace                   |
| `kubectl top nodes`                           | Display resource (CPU/memory) usage of nodes               |
| `kubectl top pods`                            | Display resource (CPU/memory) usage of Pods                |

## Tips
- Replace `<resource>` with the type of resource you are managing, such as `pod`, `service`, `deployment`, etc.
- Replace `<resource_name>` with the name of the specific resource.
- Replace `<namespace>` with the namespace you want to interact with.
- Use `-o wide` with `get` commands to get more detailed output.
- Use `-o yaml` or `-o json` to get the output in YAML or JSON format, respectively.
