# Ubuntu 16.04
**Show installed packages.**

`apt list --installed`

**Search for available packages.**

`apt search <keyworld>`

**Check Ubuntu version.**

`lsb_release -a`

**Test UDP packets listeners.**

`echo "Hello" > /dev/udp/127.0.0.1/5005`

**Python 3.6 pip install.**

`python3.6 -m pip install <package>`

**Deploy SSH key.**

```
ssh-copy-id -i ~/.ssh/some_key.pub person@yourserver.com
ssh person@yourserver.com 'chcon -t ssh_home_t ~/.ssh/authorized_keys'
```

**See which filesystems are supported.**

`cat /proc/filesystems`

**Scan local network for hosts.**

`nmap -sP 192.168.0.1/24`

**Compare real, effective and saved id of process.**

`ps -eo pid,ruid,euid,suid | grep 1234`

**Check what ports are in use.**

`lsof -i -P -n | grep LISTEN`

**View scsi drives.**

`ls -1d /sys/class/scsi_device/*/device/block/*`

# Ubuntu 18.04
## Misc
**Compare real, effective and saved id of process.**

`ps -eo pid,ruid,euid,suid | grep 1234`

**Show groups on newlines.**

`id | sed 's/,/\n/g'`

**Find and delete old files or folders.**

`find ./pattern* -mtime +10 -type f -delete`

**Compress directory.**

`tar -zcvf archive-name.tar.gz directory-name`

**Recursive search for largest files.**

`du -ckx | sort -n`

## Vim
**Remove all empty lines.**

`g/^\s*$/d`

## Networking
**Clear DNS cache.**

`sudo systemd-resolve --flush-caches`

**Show FDB (forwarding database) table.**

`bridge fdb show eth0`

**Show ARP (address resolution protocol) entries.**

`ip neigh show`

**List firewall rules by specification.**

`iptables -S`

**Helpful tcpdump commands.**

<a href="https://hackertarget.com/tcpdump-examples/">commands</a>

**See what process is listening on a port.**

`netstat -tlnp`

**Query specific DNS server.**

`dig gitlab.blueorigin.com +noall +answer`

**Port scan.**

`netcat -z -v domain.com 1-1000`

**Test TCP connection.**

`netcat domain.com 80`

**Test UDP connection.**

`netcat -u domain.com 53`

**Client/Server netcat comm**

```
server> netcat -l 4444
client> netcat domain.com 4444
````

## Processes
**View CPU and memory usage of single process.**

`ps -p <pid> -o %cpu,%mem,cmd`
