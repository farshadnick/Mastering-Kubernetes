# What exactly is a headless service.
It is used for discovering individual pods(especially IPs) which allows another service to interact directly with the Pods instead of a proxy. With NodePort, LoadBalancer, ExternalName, and ClusterIP clients usually connect to the pods through a Service (Kubernetes Services simply visually explained) rather than connecting directly.

# What does it accomplish?
The requirement is not to make single IP like in the case of other service types. We need all the pod's IP sitting behind the service.

# What are some legitimate use cases for it?
Create Stateful service.

Deploying RabbitMQ or Kafka (or any message broker service) to Kubernetes requires a stateful set for RabbitMQ cluster nodes.

Deployment of Relational databases


```
apiVersion: v1
kind: Service
metadata:
  name: headless-svc
spec:
  clusterIP: None
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```
