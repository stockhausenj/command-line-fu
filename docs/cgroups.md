# cgroups

## View cgroup
view cgroup with `ps`

`ps -o cgroup 12345`

cat cgroup

`cat /proc/$PID/cgroup`

view all cgroup options

`find /sys/fs/cgroup -path "*$CGROUP*"`

## Modifying cgroup

create memory cgroup<br/>
`sudo mkdir /sys/fs/cgroup/memory/cgroup-a`

limit memory of anything running in the cgroup cgroup-a to 4096 bytes<br/>
`echo 4096 | sudo tee /sys/fs/cgroup/memory/cgroup-a/memory.limit_in_bytes`

add process via pid to the cgroup cgroup-a<br/>
`sudo echo 12345 > /sys/fs/cgroup/memory/cgroup-a/cgroup.procs`

### using libcgroup
create memory cgroup cgroup-a<br/>
`sudo cgcreate -g memory:cgroup-a`

delete memory cgroup cgroup-a<br/>
`sudo cgdelete memory:cgroup-a`

run app app-a in cgroup cgroup-a<br/>
`sudo cgexec -g memory:cgroup-a app-a`
