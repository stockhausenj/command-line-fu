# Kubernetes

## Ubuntu 18.04

### kubectl
get assets<br/>
```bash
kubectl get <services|deployments|nodes|pods>
```
describe assets in more detail<br/>
```bash
kubectl describe <asset> <asset name>
```
get pods that a deployment is running on<br/>
```bash
deployment=<deployment name>
kubectl get pods --selector="$(kubectl describe deployments $deployment | grep Selector | awk '{print $2}')" --output=wide`
```
curl service that is exposed via NodePort<br/>
```bash
service=<service name>
curl $(kubectl get nodes | sed -n 2p | awk '{print $1}'):$(kubectl describe service $service | grep NodePort: | awk '{print $3}' | sed 's/\/.*//')
```
