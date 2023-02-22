# 1- Get Your ETCD Cert location 

```
kubectl get pod -n kube-system kube-apiserver-node1 -o yaml |grep -i etcd   #node1 is my node-name change it according to your kuber node's name
```
You will get Your ETCD Certification Location Like this
![image](https://user-images.githubusercontent.com/88557305/220760026-c881bd57-1410-456c-99b2-b6518827be9e.png)

    - --etcd-cafile=/etc/ssl/etcd/ssl/ca.pem
    - --etcd-certfile=/etc/ssl/etcd/ssl/node-node1.pem
    - --etcd-keyfile=/etc/ssl/etcd/ssl/node-node1-key.pem
    - --etcd-servers=https://192.168.4.200:2379,https://192.168.4.201:2379,https://192.168.4.202:2379
    - --storage-backend=etcd3
    - mountPath: /etc/ssl/etcd/ssl
      name: etcd-certs-0
      path: /etc/ssl/etcd/ssl
    name: etcd-certs-0


# 2- Query to ETCD 
## 2-1 Member list of Your ETCD Cluster

```
sudo ETCDCTL_API=3 etcdctl --endpoints https://192.168.4.201:2379 --cert=/etc/ssl/etcd/ssl/node-node1.pem --key=/etc/ssl/etcd/ssl/node-node1-key.pem --cacert=/etc/ssl/etcd/ssl/ca.pem  member list--prefix --keys-only |grep pods/default
```
## 2-2 List of Cluster POD

```
 sudo ETCDCTL_API=3 etcdctl --endpoints https://192.168.4.201:2379 --cert=/etc/ssl/etcd/ssl/node-node1.pem --key=/etc/ssl/etcd/ssl/node-node1-key.pem --cacert=/etc/ssl/etcd/ssl/ca.pem get /registry/ --prefix --keys-only |grep pods/default
```
![image](https://user-images.githubusercontent.com/88557305/220760674-e0f8c597-d36b-40ee-b13e-a95a4ec759de.png)

/registry/pods/default/apple-app-787f85bd89-gv6bd
/registry/pods/default/details-v1-5ffd6b64f7-l4gk5
/registry/pods/default/kubeshark-test
/registry/pods/default/productpage-v1-979d4d9fc-xhxzk
/registry/pods/default/ratings-v1-5f9699cfdf-4bkfr
/registry/pods/default/reviews-v1-569db879f5-c7fx8
/registry/pods/default/reviews-v2-65c4dc6fdc-wt87s
/registry/pods/default/reviews-v3-c9c4fb987-8756q

# GET List of ALL thing that your ETCD Store
## 1- Store All Key and values in a file 

```
sudo ETCDCTL_API=3 etcdctl --endpoints https://192.168.4.200:2379 --cert=/etc/ssl/etcd/ssl/node-node1.pem --key=/etc/ssl/etcd/ssl/node-node1-key.pem --cacert=/etc/ssl/etcd/ssl/ca.pem get /registry/ --prefix=true -w json  > ./etcd-packops.json
```
## 1-2 Filter All keys in ETCD (Kubernetes Config) 

```
for k in $(cat etcd-packops.json | jq '.kvs[].key' | cut -d '"' -f2); do echo $k | base64 --decode; echo; done
```

|> For my Test Cluster i have 1040 keys

![image](https://user-images.githubusercontent.com/88557305/220764486-a7257449-cadb-41b0-85d2-a2dc2179d4da.png)


![image](https://user-images.githubusercontent.com/88557305/220766683-193dd307-0478-4102-a0ba-9453874560bb.png)


## 1-3 GET Specific deployment 

```
sudo ETCDCTL_API=3 etcdctl --endpoints https://192.168.4.200:2379 --cert=/etc/ssl/etcd/ssl/node-node1.pem --key=/etc/ssl/etcd/ssl/node-node1-key.pem --cacert=/etc/ssl/etcd/ssl/ca.pem get /registry/deployments/default/apple-app --prefix=true -w json   | jq > farshad

 for k in $(cat farshad  | jq '.kvs[].value' | cut -d '"' -f2); do echo $k | base64 --decode; echo; done

```
