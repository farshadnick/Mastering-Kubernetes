Install Prometheus Stack 

```


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update prometheus-community


HELM_CHART_VERSION="35.5.1"

helm install kube-prom-stack prometheus-community/kube-prometheus-stack --version "${HELM_CHART_VERSION}" \
  --namespace monitoring \
  --create-namespace \


 kubectl --namespace monitoring get pods -l "release=kube-prom-stack"


```
