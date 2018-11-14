# Kubernetes

## Ubuntu 18.04

### kubectl
get services<br/>
`kubectl get services`

get deployments<br/>
`kubectl get deployments`

get pods running an application<br/>
`kubectl get pods --selector="<selector>" --output=wide`

Access via NodePort<br/>
```
service=<service name>
curl $(kubectl get nodes | sed -n 2p | awk '{print $1}'):$(kubectl describe service $service | grep NodePort: | awk '{print $3}' | sed 's/\/.*//')
```

### minikube
start with virtualbox<br/>
`minikube start --vm-driver=virtualbox`

get services<br/>
`minikube service list`
