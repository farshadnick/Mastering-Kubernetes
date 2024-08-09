## Step 1: Create a Service Account
```
kubectl create serviceaccount my-service-account
```
## Step 2: Bind the Service Account to the Appropriate Role
```
kubectl create rolebinding my-service-account-binding \
  --role=view \
  --serviceaccount=default:my-service-account \
  --namespace=default
```
```
kubectl create clusterrolebinding my-service-account-binding \
  --clusterrole=view \
  --serviceaccount=default:my-service-account
```
## Step 3: Create a Token for the Service Account
```
TOKEN=$(kubectl create token my-service-account)
```
## Step 4: Use the Token with curl to Access Kubernetes API
```
#sample api server address  https://127.0.0.1:6443/api/v1/namespaces/default/pods
curl -X GET "https://<kubernetes-api-server>/api/v1/namespaces/default/pods" \
     -H "Authorization: Bearer $TOKEN" \
     -H "Accept: application/json" \
     --insecure

```

<img width="495" alt="image" src="https://github.com/user-attachments/assets/fc092cbe-67c9-4d56-bba9-86a6559affaa">
