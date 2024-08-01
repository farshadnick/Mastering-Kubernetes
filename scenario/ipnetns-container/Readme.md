```
ip netns add packops1-ns
ip netns exec packops1-ns python3 -m http.server 80
ip netns exec packops1-ns ip a 

ip netns list


ip netns add packops2-ns
ip netns exec python3 -m http.server 80
ip netns exec packops2-ns ip a 


sudo ip link add veth-packops1 type veth peer name veth-packops2
sudo ip link set veth-packops1 netns packops1-ns
sudo ip link set veth-packops2 netns packops2-ns


sudo ip netns exec packops1-ns /bin/bash
  ip addr add 10.0.0.1/24 dev veth-packops1 
  ip link set veth-packops1 up


sudo ip netns exec packops2-ns /bin/bash
  ip addr add 10.0.0.2/24 dev veth-packops2
  ip link set veth-packops2 up
```
  ![235257778-807b9390-0855-4fff-a53f-a99c01aabe6a](https://github.com/user-attachments/assets/3799a2d5-5a16-4f16-ac8a-f3e35e6101f1)
