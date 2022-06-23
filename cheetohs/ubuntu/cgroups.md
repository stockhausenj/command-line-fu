# cgroup stuff

## Examples
### Get CPU max
1. Get process PID.
1. Get the cgroup that the PID belongs to. `cat /proc/$PID/cgroup | grep cpuset`
1. Inspect cgroup. `cat /sys/fs/cgroup/cpu/$CGROUP/cpu.cfs_quota_us`
