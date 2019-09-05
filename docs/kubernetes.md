# Kubernetes
## kubectl v1.12.2
### General Practices 
* use `--context=` to ensure correct context is targeted
### CLI
setup env<br/>
```bash
sudo ln -s $(which kubectl) /usr/bin/k
```
get assets<br/>
```bash
k get <Services|Deployments|Nodes|Pods|Configmaps>
```
describe assets in more detail<br/>
```bash
k describe <asset> <asset name>
```
get the Pods that a Deployment is running in<br/>
```bash
deployment=<deployment name>
k get pods --selector="$(k describe deployments $deployment | grep Selector | awk '{print $2}')" --output=wide
```
curl Service that is exposed through the NodePort type<br/>
```bash
service=<service name>
curl $(k get nodes | sed -n 2p | awk '{print $1}'):$(k describe service $service | grep NodePort: | awk '{print $3}' | sed 's/\/.*//')
```
delete Service and Deployment<br/>
```bash
deployment=<deployment name>
k delete services $(k get services --selector=$(k describe deployments $deployment | grep Selector | awk '{print $2}') | sed -n 2p | awk '{print $1}') 
k delete deployment $deployment
```
view Taints<br/>
```bash
k get nodes -o json | jq .items[].spec.taints
```
create busybox pod for troubleshooting<br/>
```bash
k run -i --tty --rm debug --image=busybox --restart=Never -- sh
```
restart all pods in a deployment/daemonset
```bash
k get pods -n namespace | grep pod-name | cut -d " " -f1 - | xargs k delete pod -n namespace
```
remove the CRD finalizer blocking
```bash
k patch crd/crontabs.stable.example.com -p '{"metadata":{"finalizers":[]}}' --type=merge
```

#### Istio
verify mesh policy exists
```bash
k get policies.authentication.istio.io --all-namespaces
k get meshpolicies.authentication.istio.io
```
get all istio destination rule hosts
```bash
k get destinationrules.networking.istio.io --all-namespaces -o yaml | grep "host:"
```
change envoy sidecare log level
```bash
k -n easybake exec -it -c istio-proxy easybake-ui-6bd7f9bf-9pb5w -- curl -XPOST http://localhost:15000/logging?level=trace
```
show given envoy configuration
```bash
istioctl proxy-config clusters -n istio-system istio-ingressgateway-65576f8745-kbvgl -o json
```
show routing for a port on a pod
```bash
istioctl proxy-config listeners easybake-ui-6bd7f9bf-klhvx -n easybake --port 3800 -o json
```
