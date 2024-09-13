# 1- install Prometheus stack first
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community
HELM_CHART_VERSION="62.7.0"
helm install kube-prom-stack prometheus-community/kube-prometheus-stack --version "${HELM_CHART_VERSION}" \
  --namespace monitoring \
  --create-namespace \

 kubectl --namespace monitoring get pods -l "release=kube-prom-stack"
```

#  (Optional ) If you want to change match labael service monitor 
```
helm pull prometheus-community/kube-prometheus-stack

tar -g': tar -xzvf kube-prometheus-stack-60.1.0.tgz
cd kube-prometheus-stack
vim values.yml
    serviceMonitorSelectorNilUsesHelmValues: false

    ## ServiceMonitors to be selected for target discovery.
    ## If {}, select all ServiceMonitors
    ##
    # serviceMonitorSelector: {}
    ## Example which selects ServiceMonitors with label "prometheus" set to "somelabel"
    serviceMonitorSelector:
       matchLabels:
         prometheus: test

helm install   kube-prom-stack ../kube-prometheus-stack --version "${HELM_CHART_VERSION}"   --namespace monitoring   --create-namespace
```
# 2- Apply application + service + sevice monitor (with labele helm release name)
```

kubectl apply -f app.yml
```
# 3- Change prometheus and grafana service to `NodePort`
![image](https://github.com/user-attachments/assets/1067ce72-9214-45d6-aeb9-72b397dead8c)

# 4- Check prometheus service discovery to verify
```
 kubectl get servicemonitors.monitoring.coreos.com

```
![image](https://github.com/user-attachments/assets/e58f359b-744a-4bd5-83a6-22513f865d75)
```
up{container="example-app"}
```
![image](https://github.com/user-attachments/assets/95ec351c-8476-4816-8840-11ec46757bc5)

