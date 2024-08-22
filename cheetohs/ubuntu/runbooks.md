# Runbooks
## Server Review
```bash
# What CPU architecture and how many cores and threads per core?
lscpu

# What is load and uptime?
uptime

# How much memory does the server have?
free -h

# What is exposed?
netstat -tlnp # From apt net-tools. Show TCP sockets, litening sockets, numerical addresses and the PID of program that the socket belongs to.

# What else is running?
ps auxf # Show all users' processes, in a user oriented format, and include daemon processes, and format to show parent child relationships between processes.
