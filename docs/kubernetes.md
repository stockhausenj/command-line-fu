# Kubernetes
## Cluster
### Host
* Critical OS system daemons placed in a top level cgroup.
### Scheduling
* Use pod priority to ensure system pods have scheduling priority.
### Kubelet
* Protect host from going OOM with `--eviction-hard`. It measures off of actual memory usage. Compared to memory requested.
* Pass Kubernetes system daemon cgroup in with `--kube-reserved-cgroup`. If no cgroup then reserve resources for the daemons with `--kube-reserved`.
* Pass OS system daemon cgroup in with `--system-reserved-cgroup`. If no cgroup then reserve resources for the daemons with `--system-reserved`.
* Place Kubernetes and OS system daemons in respective cgroups.
## Kubectl
### General Practices 
* Use `--context=` to ensure correct context is targeted.
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
quota  = resourcequota
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
print resource usage in namespace
```bash
k -n mynamespace describe resourcequotas
```
seeing the latest jobs from a cronjob is as  simple as listing all jobs in the namespace
```bash
k -n mynamespace get jobs
```
#### Reports
see current resource usage vs limits per namespace
```bash
k get quota -A -o custom-columns=NAMESPACE:metadata.namespace,CPU_LIMIT:{'.status.hard.limits\.cpu'},CPU_USED:{'.status.used.limits\.cpu'},MEM_LIMIT:{'.status.hard.limits\.memory'},MEM_USED:{'.status.used.limits\.memory'}
```

## Istio
Verify mesh policy exists.
```bash
k get policies.authentication.istio.io --all-namespaces
k get meshpolicies.authentication.istio.io
```
Get all istio destination rule hosts.
```bash
k get destinationrules.networking.istio.io --all-namespaces -o yaml | grep "host:"
```
Change envoy sidecare log level.
```bash
k -n easybake exec -it -c istio-proxy easybake-ui-6bd7f9bf-9pb5w -- curl -XPOST http://localhost:15000/logging?level=trace
```
Show given envoy configuration.
```bash
istioctl proxy-config clusters -n istio-system istio-ingressgateway-65576f8745-kbvgl -o json
```
Show routing for a port on a pod.
```bash
istioctl proxy-config listeners easybake-ui-6bd7f9bf-klhvx -n easybake --port 3800 -o json
```
Get configured proxy routes. useful for when traffic is not making it to destination.
```bash
istioctl proxy-config route -n istio-system istio-ingressgateway-65576f8745-kbvgl -o json
```
### Traffic Management
* Enabled locality-load balancing if it's not enabled by default.
* Use outlier detection (OD) configurations in your destination rules to circuit break unhealthy nodes.
* Use locality-prioritized load balancing to decrease latency and egress costs. This mode tells envoy to send requests to pods on nodes that match the locality labels on the sender node. This mode does not work without OD configurations.


## General Networking
### Flush iptables on a Host
```
systemctl stop docker.service
iptables -F -t nat
iptables -X -t nat
iptables -F -t mangle
iptables -X -t mangle
iptables -F
iptables -X
systemctl start docker.service
```

## Weave
<a href="https://github.com/weaveworks/weave/releases">Download</a> the weave executable and place on k8s host. Make sure the version matches what is running in the cluster.</br>
Or shell into the `weave` container in the weave pod. Use the `--local` before all commands.</br>
Connection status between all hosts on the weave overlay network. If run on a healthy node the unhealthy node wont show up in the output. If run on an unhealthy node you will get no results
```
./weave status peers
```
Connection from the host you are on to the other hosts in the k8s cluster on the weave overlay network. If run on a healthy node you will see connections that could not be established in the output if there is an unhealthy node. If run on an unhealthy node you will see all the connections fail.
```
./weave status connections
```
Other resources:
* <a href="https://www.weave.works/docs/net/latest/kubernetes/kube-addon/">weave kubernetes addon</a>
* <a href="https://www.weave.works/docs/net/latest/troubleshooting/">troubleshooting weave</a>
### Updating MTU
To update the MTU edit the `WEAVE_MTU` env variable set for the `weave` container. After the patch the `datapath` interface on all nodes will get updated but the `weave` and VETH interfaces are not updated. Restarting the node will update the interfaces that were not updated. If all production endpoints in a single cluster I suggest scheduling this when end user activity is lowest.
### Debugging
To enable debug logs edit the `weave-net` ds. Add the following `env` variable to the `weave` container.
```
name: EXTRA_ARGS
value: --log-level=debug
```
### Issues
#### Disabling Fast Datapath (fastdp) Encryption
Since the `weave-net` ds patching is 1 pod at a time non encrypted traffic is not accepted by nodes where the pod was not patched yet. Also this caused weave to overlay switch to sleeve. After the patch was fully complete restarting a pod would still result it no fastdp heartbeat ack (handleHeartbeatAck). I believe it's because of iptable rules that were not flushed/changed after the patch. After I [flushed](#flush-iptables-on-a-host) I saw established fastdp connections. Before the iptables flush I was seeing a ever increasing number of `TX-DRP` packets for the `vxlan-6784` interface.


## Etcd
The env variable `$ETCDCTL_ENDPOINTS` is set by default to the local listening address.

For checking status and health interactively it's best to use the flag `--write-out` with the value `"fields"`, while it's easier to parse programmatically when the value is `"json"`. For the below I'll assume it's all interactive.

Check health.
```
etcdctl endpoint health --write-out="fields"
```
Check status.
```
etcdctl endpoint status --write-out="fields"
```
