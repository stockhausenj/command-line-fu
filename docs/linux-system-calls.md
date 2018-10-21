# Linux System Calls

## seccomp (secure computing mode)
Filter system calls issued by a program. The filters are based on BPF (Berkley Packet Filters).</br>
The idea behind seccomp is to restrict the system calls that can be made from a process, he said. The Linux kernel has a few hundred system calls, but most of them are not needed by any given process. If a process can be compromised and tricked into making other system calls, though, it may lead to a security vulnerability that could result in the compromise of the whole system. By restricting what system calls can be made, seccomp is a key component for building application sandboxes.
```c
#include <seccomp.h> /* libseccomp */
scmp_filter_ctx ctx;
ctx = seccomp_init(SCMP_ACT_KILL); // default action: kill
seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(dup2), 2, 
                      SCMP_A0(SCMP_CMP_EQ, 1),
                      SCMP_A1(SCMP_CMP_EQ, 2));
// pass
dup2(1,2);

//fail
dup2(2, 42);
```
## dup2
Change file descriptor.
```c
// redirect stderr to stdout
dup2(1, 2);
```
## prlimit
Get and set process resource limits. This routine makes ULIMIT(3) obsolete.
```c
struct rlimit old, new; 
struct rlimit *newp; 
pid_t pid;

new.rlim_cur = /* soft limit */
new.rlim_max = /* hard limit */
newp = &new;

prlimit(pid, RLIMIT_CPU, newp, &old) /* resource options in PRLIMIT(2) */
```
There is also a CLI tool for prlimit in PRLIMIT(1).
## printk
Logging mechanism for debugging kernel space code.<br>
```c
#include <linux/kernel.h>  /* Needed for KERN_ALERT */
printk("<0>System dead.\n");
```
### from userspace
```
$ echo "2Writing critical printk messages from userspace" >/dev/kmsg
$ dmesg
```
### console_loglevel
To determine current console_loglevel: `$ cat /proc/sys/kernel/printk`<br>
The output values are in respect: current default minimum boot-time-default
