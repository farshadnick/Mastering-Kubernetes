# 1- install Gate Keeper
```
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.17/deploy/gatekeeper.yaml
```
# 2- Create a ConstraintTemplate:
This template defines the logic that checks for the presence of nodeName.
```
#pod-nodeName-template.yaml
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8sdenynodename
spec:
  crd:
    spec:
      names:
        kind: K8sDenyNodeName
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sdenynodename

        violation[{"msg": msg}] {
          input.review.object.spec.nodeName
          msg := "Using nodeName in Pod specification is not allowed."
        }

```
Apply Contrain Template
```
kubectl apply -f pod-nodeName-template.yaml
```
Include Constrain to and specify where to apply 
```
#deny-nodename.yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sDenyNodeName
metadata:
  name: pod-nodename-restriction
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
```
Apply contrain Policy template
```
kubectl apply -f deny-nodename.yaml
```

Let's Check it by adeploying a pod with specific **nodename**
```
#nodename-pod.yml
apiVersion: v1
kind: Pod
metadata:
 name: nginx
 labels:
  name: nginx
spec:
 containers:
 - name: nginx
   image: nginx
   ports:
   - containerPort: 8080
 nodeName: node02
```

The Output must be something like that
![image](https://github.com/user-attachments/assets/249c4dde-5adb-4448-9413-70ad1215ff78)



```
