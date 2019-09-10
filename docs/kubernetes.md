# Kubernetes
## kubectl v1.12.2
### General Practices 
* use `--context=` to ensure correct context is targeted
### CLI
setup env<br/>
```bash
sudo ln -s $(which kubectl) /usr/bin/k
```
resource short-names<br/>
```bash
svc    = service
ds     = daemonset
po     = pod
deploy = deployment
vs     = virtualservice
gw     = gateway
ksvc   = knative service
```
get resource YAML<br/>
```bash
k get <resource-type> <resoruce-id> -n <namespace> -o yaml
```
get the pods from a Deployment<br/>
```bash
deployment=<deployment name>
k get pod --selector="$(k describe deployments $deployment | grep Selector | awk '{print $2}')" --output=wide
```
delete Service and Deployment<br/>
```bash
deployment=<deployment-id>
namespace=<namespace>
k delete services $(k get svc --selector=$(k describe deployments $deployment -n $namespace | grep Selector | awk '{print $2}') | sed -n 2p | awk '{print $1}') 
k delete deploy $deployment -n $namespace
```
view all node taints<br/>
```bash
k get nodes -o json | jq '.items[] | .metadata.name, .spec.taints'
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
