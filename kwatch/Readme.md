1- Configmap

```
#config.yml
apiVersion: v1
kind: Namespace
metadata:
  name: kwatch
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: kwatch
  namespace: kwatch
data:
  config.yaml: |
    alert:
      telegram:
        token: TOKEN
        chatId: CHAT_ID
```
```
kubectl apply -f config.yml
```
2- Deploy Kwatch 
```
kubectl apply -f https://raw.githubusercontent.com/abahmed/kwatch/v0.8.4/deploy/deploy.yaml
```
