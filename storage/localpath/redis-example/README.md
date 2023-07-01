
Connect to the container and write some data.

Connect to the container and run the redis-cli:
```
    kubectl exec -it redispod redis-cli
```

Set the key space server:name and value "redis server":

```
    SET server:name "redis server"
```
    Run the GET command to verify the value was set:
```
    GET server:name
```
    Exit the redis-cli:
```
    QUIT
```
Delete `redispod` and create a new pod named `redispod2`.

    Delete the existing redispod:
```
    kubectl delete pod redispod
```
    Open the file redispod.yaml and change line 4 from name: redispod to:
    name: redispod2

    Create a new pod named redispod2:
```
    kubectl apply -f redispod.yaml
```
Verify the volume has persistent data.

    Connect to the container and run redis-cli:
```
    kubectl exec -it redispod2 redis-cli
```
    Run the GET command to retrieve the data written previously:
```
    GET server:name
```
    Exit the redis-cli:
```
    QUIT
```
