# Install kiali plugin 
```
git clone https://github.com/istio/istio.git
kubectl apply -f istio/samples/addons
```

# make nodeport service for kiali 

```
apiVersion: v1
kind: Service
metadata:
  name: kiali-nodeport
  namespace: istio-system
spec:
  type: NodePort
  ports:
    - port: 20001
      targetPort: 20001
      nodePort: 30001
  selector:
    app.kubernetes.io/instance: kiali
    app.kubernetes.io/name: kiali
```
