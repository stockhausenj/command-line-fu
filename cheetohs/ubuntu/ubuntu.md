# Ubuntu X.X
## Misc
Check Ubuntu version.

`lsb_release -a`

Set journal file size/time limit.

```bash
sudo journalctl --vacuum-size=100M
sudo journalctl --vacuum-time=10d
```

Show groups on newlines.

`id | sed 's/,/\n/g'`

Recursive search for largest files.

`du -ckx | sort -n`

Watch a path and run a command whenever modification detected with [watchexec](https://github.com/watchexec/watchexec).

`watchexec -r -e py -- python server.py`

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

Check where a package will be installed from.

`apt-cache policy _package_`

## Find
Find and delete.

`find . -type f -name "*.log" -exec rm {} \;`

Find and delete old files or folders.

`find ./pattern* -mtime +10 -type f -delete`

Search for files recursively to find an expression.

`find . -type f -exec grep -l "nltk" {} \;`

### File Searching
Find occurences of a pattern in log, and then sort by highest occurences.

`sort file.log | uniq -c | sort -bgr`

### Code Searching
Silver Searcher

`ag <pattern>`

ugrep

`ug <pattern>`

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

Show FDB (forwarding database) table.

`bridge fdb show eth0`

Show ARP (address resolution protocol) entries.

`ip neigh show`

List firewall rules by specification.

`iptables -S`

Delete firewall rule by rule number.

```bash
iptables -L --line-numbers
iptables -D <CHAIN>(e.g INPUT) <LINE NUM>
```

Helpful tcpdump commands.

<a href="https://hackertarget.com/tcpdump-examples/">commands</a>

### SSL
Get remote certificate details with curl.

`curl --insecure -vvI https://site.domain.com 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'`

Get server certificate with openssl.

`openssl s_client -showcerts -connect site.domain.com:443 </dev/null 2>/dev/null | openssl x509 -text -noout`

Get server certificate, certificate chain and other SSL/TLS details with openssl.

`openssl s_client -showcerts -connect site.domain.com:443 </dev/null 2>/dev/null`

Get certificate chain and other SSL/TLS details with openssl.

`openssl s_client -connect site.domain.com:443 </dev/null 2>/dev/null`

Read x509 certificate.

`openssl x509 -in site.cer -text`

### DNS
Clear DNS cache.

`sudo systemd-resolve --flush-caches`

Clean dig output.
 
 ```
# only return value
dig google.com +short
# only return answer
dig google.com +noall +answer
```

Query specific DNS resolver.

`dig google.com @1.1.1.1`

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

### Netstat
Connection count by state.

`netstat -ant | awk '{print $6}' | sort | uniq -c | sort -n`

See what process is listening on a port.

`netstat -tlnp`

### Netcat
Port scan.

`netcat -z -v domain.com 1-1000`

Test TCP connection.

`netcat -v domain.com 80`

Test UDP connection.

`netcat -u domain.com 53`

Send HTTP body.

`printf 'HEAD / HTTP/1.1\r\nHost: neverssl.com\r\nConnection: close\r\n\r\n' | nc neverssl.com 80`

Client/Server netcat comm.

```bash
server> netcat -l 4444
client> netcat domain.com 4444
```

## Processes
View CPU and memory usage of single process.

`ps -p <pid> -o %cpu,%mem,cmd`

Compare real, effective and saved id of process.

`ps -eo pid,ruid,euid,suid | grep 1234`

## Storage
List all mounted filesystems with mount options.

`findmnt`

Find the UUIDs for block-level devices

`blkid`

See which filesystems are supported.

`cat /proc/filesystems`

View scsi drives.

`ls -1d /sys/class/scsi_device/*/device/block/*`

Compress and gzip directory.

`tar -zcvf archive-name.tar.gz directory-name`

### File Sync
Transfer only changed bits of data.

`rsync [options] source destination`

## NTP
View status.

`timedatectl status`
