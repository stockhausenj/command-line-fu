# Kubernetes

## Ubuntu 18.04

## kubectl
get assets<br/>
```bash
kubectl get <Services|Deployments|Nodes|Pods>
```
describe assets in more detail<br/>
```bash
kubectl describe <asset> <asset name>
```
get the Pods that a Deployment is running in<br/>
```bash
deployment=<deployment name>
kubectl get pods --selector="$(kubectl describe deployments $deployment | grep Selector | awk '{print $2}')" --output=wide
```
curl Service that is exposed through the NodePort type<br/>
```bash
service=<service name>
curl $(kubectl get nodes | sed -n 2p | awk '{print $1}'):$(kubectl describe service $service | grep NodePort: | awk '{print $3}' | sed 's/\/.*//')
```
delete Service and Deployment<br/>
```bash
deployment=<deployment name>
kubectl delete services $(kubectl get services --selector=$(kubectl describe deployments $deployment | grep Selector | awk '{print $2}') | sed -n 2p | awk '{print $1}') 
kubectl delete deployment $deployment
```
