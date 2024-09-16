
Kubernetes is amazing for managing containers, but keeping it secure can be tricky. That's where Kubescape comes in—a super handy, open-source security tool for Kubernetes clusters. It helps you lock down your system from development all the way through runtime, making sure your cluster stays secure at every stage.


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/06cca1lsbzy7gpnvlwtm.png)

Here’s the quick rundown:

**Cluster Hardening** : Kubescape checks your cluster’s setup and flags potential vulnerabilities, following industry standards like the CIS benchmarks.

**Posture Management** : It continuously monitors your cluster’s security posture, letting you know if anything needs attention.

**Runtime Security** : Kubescape also keeps an eye on things when your system is live, catching any weird behavior or misconfigurations that could lead to security issues.

It’s perfect for developers and security teams who want to integrate security checks early in the development process and keep monitoring once the cluster is up and running. Plus, since it’s open-source, it’s flexible, accessible, and free!

In short, Kubescape is like having a security guard for your Kubernetes cluster, from start to finish. Easy to use, reliable, and it makes sure your cluster stays safe.
Installation 

`curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash`


Take look at some example:

**Scan a running Kubernetes cluster:**
`kubescape scan`

**Scan NSA framework**

Scan a running Kubernetes cluster with the NSA framework:

`kubescape scan framework nsa`

**Scan MITRE framework**

Scan a running Kubernetes cluster with the MITRE ATT&CK® framework:

`kubescape scan framework mitre`

**Scan specific namespaces:**

`kubescape scan --include-namespaces development,staging,production`

**Scan local YAML files**

`kubescape scan /path/to/directory-or-directory`

Take a look at the example.
Scan git repository

**Scan Kubernetes manifest files from a Git repository:**

`kubescape scan https://github.com/kubescape/kubescape`



![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/skyy3gprjefluzxq612a.png)


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ipvi3ens1yzd4zxuyfo0.png)


![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1s7ki9rsytfhjv3ehx3v.png)

Conclusion

Kubescape offers a powerful and user-friendly way to safeguard your Kubernetes clusters from development to runtime. With features like compliance auditing, hardening recommendations, and continuous monitoring, it fills a crucial need in Kubernetes security. For teams looking to integrate security seamlessly across their workflows, Kubescape is an essential tool in their DevSecOps pipeline.



About Author :
Hi 👋, I’m Farshad Nick (Farshad nickfetrat)

    📝 I regularly write articles on packops.dev and packops.ir
    💬 Ask me about Devops , Cloud , Kubernetes , Linux
    📫 How to reach me on my linkedin
    Here is my Github repo



