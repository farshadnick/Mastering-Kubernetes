```
#write your Kubernetes nodes ip :
#192.168.7.192
#192.168.7.193
#192.168.7.197
```
# Clone Kubespray
```
mkdir kubernetes_installation/
cd kubernetes_installation/
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray/
```
# install requirements for kubespray 
```
apt update && apt install python3-pip ansible
pip install -r requirements.txt  --break-system-packages
pip3 install ruamel.yaml --break-system-packages
# Run it on ALL Nodes
apt install sshpass -y  
```
# Determine Your Kubernetes nodes IP
```
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(192.168.7.192 192.168.7.193 192.168.7.197)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```
# You will be asked for ssh pass and sudo pass
```
ansible-playbook -i inventory/mycluster/hosts.yaml --user geek --become -kK cluster.yml
```
