# cgroup stuff

## Examples
### Get cgroup
1. Get process PID.
1. Get the cgroup that the PID belongs to: `cat /proc/$PID/cgroup`
1. View cgroup options: `find /sys/fs/cgroup -path "*/system.slice/ssh.service/*`
