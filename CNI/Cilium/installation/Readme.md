kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumbgpadvertisements.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumbgpclusterconfigs.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumbgpnodeconfigs.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumbgppeerconfigs.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumcidrgroups.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumclusterwidenetworkpolicies.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumegressgatewaypolicies.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumendpoints.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumenvoyconfigs.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumidentities.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumloadbalancerippools.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumlocalredirectpolicies.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliuml2announcementpolicies.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumnetworkpolicies.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumnodeconfigs.yaml

kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.19.3/pkg/k8s/apis/cilium.io/client/crds/v2/ciliumnodes.yaml


# 1- Install api gateway first
```
kubectl apply -f experimental-install.yaml
```

# 2- Install all required CRDs
```
kubectl apply -f  all-cilium-crd.yaml
```

# 3- add arad helm chart 
```
helm repo add arad https://registry.aradarpanet.ir/repository/Helm-Hosted/
helm repo update
helm install  cilium arad/cilium   -n kube-system     -f values2.yml
```
