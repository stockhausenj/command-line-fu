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
# setrlimit
Set resource limits.
```c
struct rlimit rl; 
getrlimit (RLIMIT_CPU, &rl); 
rl.rlim_cur = 1; 
setrlimit (RLIMIT_CPU, &rl); 
```
