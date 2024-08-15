Building a Kubernetes 1.29 Cluster with kubeadm
Introduction

This lab will allow you to practice the process of building a new Kubernetes cluster. You will be given a set of Linux servers, and you will have the opportunity to turn these servers into a functioning Kubernetes cluster. This will help you build the skills necessary to create your own Kubernetes clusters in the real world.
Solution

Log in to the lab server using the credentials provided:
ssh cloud_user@<PUBLIC_IP_ADDRESS>
Install Packages

    #Log into the control plane node. (Note: The following steps must be performed on all three nodes.)
    #Create configuration file for containerd:
    
    cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
    overlay
    br_netfilter
    EOF

    
    #Load modules:
    sudo modprobe overlay

    sudo modprobe br_netfilter
    #Set system configurations for Kubernetes networking:
    
    cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
    net.bridge.bridge-nf-call-iptables = 1
    net.ipv4.ip_forward = 1
    net.bridge.bridge-nf-call-ip6tables = 1
    EOF
    
    #Apply new settings:
    sudo sysctl --system
    #Install containerd:
    sudo apt-get update && sudo apt-get install -y containerd
    #Create default configuration file for containerd:
    sudo mkdir -p /etc/containerd
    #Generate default containerd configuration and save to the newly created default file:
    sudo containerd config default | sudo tee /etc/containerd/config.toml
    #Restart containerd to ensure new configuration file usage:
    sudo systemctl restart containerd
    #Verify that containerd is running:
    sudo systemctl status containerd
    #Disable swap:
    sudo sed -i '/\tswap\t/d' /etc/fstab && sudo swapoff -a
    #Install dependency packages:
    sudo apt-get update && sudo apt-get install -y apt-transport-https curl
    
    #Download and add GPG key:
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    #Add Kubernetes to repository list:
    KUBERNETES_VERSION=1.29
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v$KUBERNETES_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$KUBERNETES_VERSION/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    apt update && apt-get install -y kubelet=1.29.0-1.1 kubectl=1.29.0-1.1 kubeadm=1.29.0-1.1
    
    #Log into both worker nodes to perform previous steps.

Initialize the Cluster

    Initialize the Kubernetes cluster on the control plane node using kubeadm (Note: This is only performed on the Control Plane Node):
    sudo kubeadm init --pod-network-cidr 192.168.0.0/16 --kubernetes-version 1.29.0
    Set kubectl access:
    mkdir -p $HOME/.kube

    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    Test access to cluster:
    kubectl get nodes

Install the Calico Network Add-On

    On the control plane node, install Calico Networking:
    kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
    Check status of the control plane node:
    kubectl get nodes

Join the Worker Nodes to the Cluster

    In the control plane node, create the token and copy the kubeadm join command (NOTE:The join command can also be found in the output from kubeadm init command):
    kubeadm token create --print-join-command
    In both worker nodes, paste the kubeadm join command to join the cluster. Use sudo to run it as root:
    sudo kubeadm join ...
    In the control plane node, view cluster status (Note: You may have to wait a few moments to allow all nodes to become ready):
    kubectl get nodes

Conclusion

Congratulations — you've completed this hands-on lab!
