Building a Kubernetes 1.29 Cluster with kubeadm
Introduction

This lab will allow you to practice the process of building a new Kubernetes cluster. You will be given a set of Linux servers, and you will have the opportunity to turn these servers into a functioning Kubernetes cluster. This will help you build the skills necessary to create your own Kubernetes clusters in the real world.
Solution

Log in to the lab server using the credentials provided:
ssh cloud_user@<PUBLIC_IP_ADDRESS>
Install Packages

# Step 1: Enable iptables Bridged Traffic on all the Nodes
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```

# Step 2: Disable swap on all the Nodes
```
sudo swapoff -a
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true
```
# Step 3: Install Containerd Runtime On All The Nodes
```
sudo apt-get update && sudo apt-get install -y containerd
```
# Step 4: Configure Containerd 
```
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/            SystemdCgroup = false/            SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
```
# Step 5: Install Kubeadm & Kubelet & Kubectl on all Nodes
```
KUBERNETES_VERSION=1.29

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v$KUBERNETES_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$KUBERNETES_VERSION/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update && apt-get install -y kubelet=1.29.0-1.1 kubectl=1.29.0-1.1 kubeadm=1.29.0-1.1
```
# Step 6: Initialize Cluster 
```
NODENAME=$(hostname -s)
POD_CIDR="10.30.0.0/16"
kubeadm init   --pod-network-cidr=$POD_CIDR --node-name $NODENAME 
```

# Step 6: Copy Join command in workers 
![kubeadm-1536x864](https://github.com/user-attachments/assets/5e37d182-5bae-40c8-93c9-73f06604ceea)


# step 7:  Install CNI Plugin
```
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```
