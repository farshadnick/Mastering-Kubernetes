# Create Service ext-svc.yml
```
apiVersion: v1
kind: Service
metadata:
  name: external-service
spec:
  type: ExternalName
  externalName: varzesh3.com
  ports:
  - port: 80
```

```
lynx   external-service

```
![Uploading image.png…]()
