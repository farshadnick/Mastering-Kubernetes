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
![image](https://github.com/user-attachments/assets/151b4f70-bf8c-4746-9450-830eb88bfa31)
