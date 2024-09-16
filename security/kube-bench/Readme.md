 What Kube-bench does for us ?

Kube-bench runs tests to verify that your Kubernetes installation meets these security benchmarks. It provides detailed output on the areas where your cluster complies with the benchmark and highlights the aspects that need attention. This automated auditing tool is invaluable for system administrators, DevOps teams, and security professionals who aim to maintain robust security postures for their Kubernetes environments.

In this article, we will delve into the functionality of Kube-bench, explore its key features, and demonstrate how to effectively use it to enhance the security of your Kubernetes clusters. Whether you're a seasoned Kubernetes administrator or a newcomer to the world of container orchestration, understanding and utilizing Kube-bench is an essential step in fortifying your infrastructure against potential security threats.


How does kube-bench work ?

Kube-bench runs a simple kubernetes job in order to check cis security check

so all thing that we need to do is deploy that job.

there are lots of kube-bench job for different environment like EKS, GKE ... 

here is kube-bench git repo you can find jobs there:

https://github.com/aquasecurity/kube-bench/tree/main


but in my scenario i've installed 3 node kubernetes cluster on bare-metal so wee need to do :
```
$ kubectl apply -f  https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml

$ kubectl get pods
NAME                      READY   STATUS              RESTARTS   AGE
kube-bench-j76s9   0/1     ContainerCreating   0          3s

# Wait for a few seconds for the job to complete
$ kubectl get pods
NAME                      READY   STATUS      RESTARTS   AGE
kube-bench-j76s9   0/1     Completed   0          11s

# The results are held in the pod's logs
kubectl logs kube-bench-j76s9
[INFO] 1 Master Node Security Configuration
[INFO] 1.1 API Server
...
```
Finally you can see the Test's result 

![1719262885672](https://github.com/user-attachments/assets/014ec61b-b61c-4968-b5bf-40ba128ef20f)

