# Systemd
## Shutdown
```bash
systemctl halt      # Shut down and halt the system
systemctl poweroff  # Shut down and power-off the system
systemctl reboot    # Shut down and reboot the system
```

```bash
# reboot.target
[Unit]
Description=System Reboot
Documentation=man:systemd.special(7)
DefaultDependencies=no
Requires=systemd-reboot.service
After=systemd-reboot.service
AllowIsolate=yes
JobTimeoutSec=30min
JobTimeoutAction=reboot-force

[Install]
Alias=ctrl-alt-del.target
```

```bash
sudo systemctl list-dependencies --all --recursive reboot.target
reboot.target
○ └─systemd-reboot.service
●   ├─system.slice
●   │ └─-.slice
○   ├─final.target
○   ├─shutdown.target
○   └─umount.target
```

```bash
# /etc/systemd/system/clean.service
[Unit]
Description=Clean on shutdown
Before=shutdown.target    # implicit

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/bin/cleanup

[Install]
WantedBy=shutdown.target
```

```bash
# /etc/systemd/system/clean.service
[Unit]
Description=Clean on shutdown
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/true
ExecStop=/usr/local/bin/cleanup

[Install]
WantedBy=multi-user.target
```

