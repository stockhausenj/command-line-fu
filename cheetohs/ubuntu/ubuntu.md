# Ubuntu X.X
## Misc
Check Ubuntu version.

`lsb_release -a`

Python 3.6 pip install.

`python3.6 -m pip install <package>`

See which filesystems are supported.

`cat /proc/filesystems`

Compare real, effective and saved id of process.

`ps -eo pid,ruid,euid,suid | grep 1234`

View scsi drives.

`ls -1d /sys/class/scsi_device/*/device/block/*`

Compare real, effective and saved id of process.

`ps -eo pid,ruid,euid,suid | grep 1234`

Show groups on newlines.

`id | sed 's/,/\n/g'`

Find and delete old files or folders.

`find ./pattern* -mtime +10 -type f -delete`

Compress and gzip directory.

`tar -zcvf archive-name.tar.gz directory-name`

Recursive search for largest files.

`du -ckx | sort -n`

Check where a package will be installed from.

`apt-cache policy _package_`

## Apt
Show installed packages.

`apt list --installed`

Search for available packages.

`apt search <keyworld>`

Fix broken packages.

```bash
apt clean
apt autoremove
apt update --fix-missing
apt install -f
```

See which packages can be upgraded.

`apt list --upgradeable -a`

Change how apt handles a package.

`apt mark <command> <package>`

## Vim
Remove all empty lines.

`g/^\s*$/d`

## Networking
###  Misc
Scan local network for hosts.

`nmap -sP 192.168.0.1/24`

Check what ports are in use.

`lsof -i -P -n | grep LISTEN`

Test UDP packets listeners.

`echo "Hello" > /dev/udp/127.0.0.1/5005`

Clear DNS cache.

`sudo systemd-resolve --flush-caches`

Show FDB (forwarding database) table.

`bridge fdb show eth0`

Show ARP (address resolution protocol) entries.

`ip neigh show`

List firewall rules by specification.

`iptables -S`

Helpful tcpdump commands.

<a href="https://hackertarget.com/tcpdump-examples/">commands</a>

Get remote certificate details with curl.

`curl --insecure -vvI https://site.domain.com 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'`

### SSH
Deploy SSH key.

```bash
ssh-copy-id -i ~/.ssh/some_key.pub person@yourserver.com
ssh person@yourserver.com 'chcon -t ssh_home_t ~/.ssh/authorized_keys'
```

Forward SSH agent.

`ssh -A server`

Skipping known hosts check.

`ssh -o StrictHostKeyChecking=no user@host.com`

### Dig
Clean output.
 
 ```
# only return value
dig google.com +short
# only return answer
dig google.com +noall +answer
```

Query specific DNS resolver.

`dig google.com @1.1.1.1`

### Netstat
Connection count by state.

`netstat -ant | awk '{print $6}' | sort | uniq -c | sort -n`

See what process is listening on a port.

`netstat -tlnp`

### Netcat
Port scan.

`netcat -z -v domain.com 1-1000`

Test TCP connection.

`netcat domain.com 80`

Test UDP connection.

`netcat -u domain.com 53`

Client/Server netcat comm.

```bash
server> netcat -l 4444
client> netcat domain.com 4444
```

## Processes
View CPU and memory usage of single process.

`ps -p <pid> -o %cpu,%mem,cmd`

## Filesystems
List all mounted filesystems with mount options.

`findmnt`

Find the UUIDs for block-level devices

`blkid`

## NTP
View status.

`timedatectl status`