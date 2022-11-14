
etcd is an open source distributed key-value store used to hold and manage the critical information that distributed systems need to keep running. Most notably, it manages the configuration data, state data, and metadata for Kubernetes, the popular container orchestration platform

**ETCD Benefits**
1.    Fully replicated: Every node in an etcd cluster has access the full data store.
1.   Highly available: etcd is designed to have no single point of failure and gracefully tolerate hardware failures and network partitions.
1.    Reliably consistent: Every data ‘read’ returns the latest data ‘write’ across all clusters.
1.    Fast: etcd has been benchmarked at 10,000 writes per second.
1.    Secure: etcd supports automatic Transport Layer Security (TLS) and optional secure socket layer (SSL) client certificate authentication. Because etcd stores vital and highly sensitive configuration data, administrators should implement role-based access controls within the deployment and ensure that team members interacting with etcd are limited to the least-privileged level of access necessary to perform their jobs.
1.    Simple: Any application, from simple web apps to highly complex container orchestration engines such as Kubernetes, can read or write data to etcd using standard HTTP/JSON  tools.
