# ansible server should access to kubernetes server by ssh (key based)
ssh-copyid node1 node2 node3

git clone https://github.com/kubernetes-sigs/kubespray.git /opt
cd /opt/kubespray
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(192.168.4.200 192.168.4.201 192.168.4.202)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}


vim inventory/mycluster/inventory.ini

[kube_control_plane]
 node1
 node2
 node3

[etcd]
 node1
 node2
 node3

[kube_node]
 node1
 node2
 node3



ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
