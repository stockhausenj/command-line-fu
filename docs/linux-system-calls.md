# Linux System Calls

## seccomp
Filter system calls issue by a program.

## dup2
Change file descriptor. Basic example can redirect stderr to stdout.
```
dup2(1, 2);
```
# setrlimit
Set resource limits.
