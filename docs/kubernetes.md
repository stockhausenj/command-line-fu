# Kubernetes
## kubectl v1.12.2
### General Practices 
* use `--context=` to ensure correct context is targeted
### CLI
get assets<br/>
```bash
kubectl get <Services|Deployments|Nodes|Pods|Configmaps>
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
view Taints<br/>
```bash
kubectl get nodes -o json | jq .items[].spec.taints
```
create busybox pod for troubleshooting<br/>
```bash
kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh
```
restart all pods in a deployment/daemonset
```bash
kubectl get pods -n namespace | grep pod-name | cut -d " " -f1 - | xargs kubectl delete pod -n namespace
```
remove the CRD finalizer blocking
```bash
kubectl patch crd/crontabs.stable.example.com -p '{"metadata":{"finalizers":[]}}' --type=merge
```

#### Istio
verify mesh policy exists
```bash
kubectl get policies.authentication.istio.io --all-namespaces
kubectl get meshpolicies.authentication.istio.io
```
get all istio destination rule hosts
```bash
kubectl get destinationrules.networking.istio.io --all-namespaces -o yaml | grep "host:"
```
change envoy sidecare log level
```bash
kubectl -n easybake exec -it -c istio-proxy easybake-ui-6bd7f9bf-9pb5w -- curl -XPOST http://localhost:15000/logging?level=trace
```
show given envoy configuration
```bash
istioctl proxy-config clusters -n istio-system istio-ingressgateway-65576f8745-kbvgl -o json
```
show routing for a port on a pod
```bash
istioctl proxy-config listeners easybake-ui-6bd7f9bf-klhvx -n easybake --port 3800 -o json
```
