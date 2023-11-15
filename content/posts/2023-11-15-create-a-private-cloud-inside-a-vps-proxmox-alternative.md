---
title: Create a private cloud inside a VPS (Proxmox alternative)
draft: true
date: 2023-11-15T19:41:14.109Z
---
It great to have a private cloud to create vm and validate lot of ideas of applications and infrastructure.

With Home Lab we can use great projects like proxmox, for most VPS provider is not an official image that can be used (beside can be imported).

For provide an alternative for who like me want to create and destroy lot of VM's that are used during several weeks for labs the following tutorial provide an alternative using LXD + LXDware:

Requirements:
- VM with support for KVM
- 4GB or more of RAM 
- Debian 12

Glossary:

- host (your actual desktop)
- server (where we will run the lxd daemon)
- vm (a Virtual Machine create with LXD)


Create a VPS of your choice with support for KVM, I will use Debian 12 in digital ocean then ssh in it:

1) Check that KVM is working:

```shell
apt update
apt install -y cpu-checker
```

Then using kvm-ok we can validate if VM or host support KVM:

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
```

2) Install main components

```
apt install --no-install-recommends -y lxd qemu-system qemu-system-x86 bridge-utils ovmf
```

3) Initialize with lxd init

It will create mainly configuraiton for use LXD

```
root@debian-s-2vcpu-4gb-sfo3-01:~# lxd init
Would you like to use LXD clustering? (yes/no) [default=no]: 
Do you want to configure a new storage pool? (yes/no) [default=yes]: 
Name of the new storage pool [default=default]: 
Would you like to connect to a MAAS server? (yes/no) [default=no]: 
Would you like to create a new local network bridge? (yes/no) [default=yes]: 
What should the new bridge be called? [default=lxdbr0]: 
What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: 
What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]: 
Would you like the LXD server to be available over the network? (yes/no) [default=no]: 
Would you like stale cached images to be updated automatically? (yes/no) [default=yes]: 
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]:
```

4) Run first LXC VM

```
root@debian-s-2vcpu-4gb-sfo3-01:~# lxc launch images:ubuntu/22.04/cloud vm01 --vm
If this is your first time running LXD on this machine, you should also run: lxd init

Creating ubuntu-vm
Retrieving image: rootfs: 50% (37.10MB/s)
Creating vm01
Starting vm01
```


5) Install lxdware (will use a docker running inside a little VM)

https://lxdware.com/

Create an instance for lxdware run:
```
$ lxc launch images:ubuntu/22.04/cloud lxdware --vm --config limits.memory=512MiB --config limits.cpu=1
```

Install docker dependency
```
root@debian-s-2vcpu-4gb-sfo3-01:~# lxc shell lxdware
root@lxdware:~# apt update && apt install -y docker.io
```

Create a container for lxdware:

```shell
root@lxdware:~# docker run -d --name dashboard -p 8000:80 -v ~/lxdware:/var/lxdware --restart=always lxdware/dashboard:3.8.0

# Then check that everything is ok inside the lxdware VM
root@lxdware:~# docker ps
```

6) Access the VM's like a local network 

For we will use https://github.com/sshuttle/sshuttle that allow we forward a CIDR acting like we are inside our host and access through secure SSH connection.

Lets discover which is the CIDR inside the server that host has access that we want access (if you changed default bridge change inside script):
```
root@debian-s-2vcpu-4gb-sfo3-01:~# ip route | grep lxdbr0 | awk '{print $1}'
10.254.155.0/24
```

With the cidr we will create a command to forward traffic from our host to vm (passing by the server):

sudo sshuttle --dns -NHr <SERVER_USER>@<SERVER_IP> <CIDR>


Example using the ephemeral droplet that I create:
```
sergsoares-personal ~> sudo sshuttle --dns -NHr root@164.90.157.217 10.254.155.0/24Password:
The authenticity of host '164.90.157.217 (164.90.157.217)' can't be established.
ED25519 key fingerprint is SHA256:jWmcSw1VHy/dMGQret7ewcaKlyMIixnLRbCGlJIGPlU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '164.90.157.217' (ED25519) to the list of known hosts.
c : Connected to server.
HH: ['netstat', '-n'] failed: FileNotFoundError(2, 'No such file or directory')
```

Now lets discover inside server the IP for lxdware vm

```
root@debian-s-2vcpu-4gb-sfo3-01:~# lxc list
+---------+---------+------------------------+-------------------------------------------------+-----------------+-----------+
|  NAME   |  STATE  |          IPV4          |                      IPV6                       |      TYPE       | SNAPSHOTS |
+---------+---------+------------------------+-------------------------------------------------+-----------------+-----------+
| lxdware | RUNNING | 172.17.0.1 (docker0)   | fd42:3898:ac14:5e8c:216:3eff:fe1a:6b53 (enp5s0) | VIRTUAL-MACHINE | 0         |
|         |         | 10.254.155.66 (enp5s0) |                                                 |                 |           |
+---------+---------+------------------------+-------------------------------------------------+-----------------+-----------+

```


And with the IP and the sshuttle tunnel we can access, in our case http://10.254.155.66:8000/


7) Configure lxdware:



It need be executed inside server create the file, :

```
root@debian-s-2vcpu-4gb-sfo3-01:~# cat << EOF > lxdware.crt
-----BEGIN CERTIFICATE-----
MIICKzCCAbKgAwIBAgIBADAJBgcqhkjOPQQBMFcxEDAOBgNVBAMMB0xYRFdBUkUx
CzAJBgNVBAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRl
cm5ldCBXaWRnaXRzIFB0eSBMdGQwHhcNMjMxMTE1MTkyMzMxWhcNMzMxMTEyMTky
MzMxWjBXMRAwDgYDVQQDDAdMWERXQVJFMQswCQYDVQQGEwJBVTETMBEGA1UECAwK
U29tZS1TdGF0ZTEhMB8GA1UECgwYSW50ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMHYw
EAYHKoZIzj0CAQYFK4EEACIDYgAEkbi6FpW266IqBGgXyqBHLsu+w3w6AR3MvCFv
9zNh2OpiKdsEKMwlL1WQl7ZsFPft872bikEA2bPQRr7bOIBagY8pdx/PFqK2Azqt
R+xnx9Ab+SLGT2HGAlnJ4wvwNQtVo1MwUTAdBgNVHQ4EFgQUbaIf1LDce+CnWZia
6lp2H6mhfRcwHwYDVR0jBBgwFoAUbaIf1LDce+CnWZia6lp2H6mhfRcwDwYDVR0T
AQH/BAUwAwEB/zAJBgcqhkjOPQQBA2gAMGUCMQCg1GNihz9bWhJNjVL42HrWs0r0
08btHv2gSyLrWuEoofnZJXcizrfoArFqmsO6y70CMGEqxFAalwPx6ruP2DMh34ns
ngd6DstnM4kvJVXiDeaXiR/0HixeyB3TyuIakfTc+Q==
-----END CERTIFICATE-----
EOF

root@debian-s-2vcpu-4gb-sfo3-01:~#  lxc config trust add lxdware.crt 

root@debian-s-2vcpu-4gb-sfo3-01:~#  lxc config set core.https_address [::] 
```


With the certificate alloweb by lxd server, we can connect from lxdware inside lxd server:









Errors:

For found detailed logs:
```
cat /var/log/lxd/lxd.log
```

If when try to launch a VM you receive a error like that, check again the procedure to install dependencies
```
Error: Failed instance creation: Failed creating instance record: Instance type "virtual-machine" is not supported on this server: QEMU command not available for CPU architecture
```

https://lxdware.com/installing-the-lxd-dashboard-using-the-docker-image/
https://documentation.ubuntu.com/lxd/en/latest/installing/
https://www.cyberciti.biz/faq/install-lxd-on-ubuntu-22-04-lts-using-apt-snap/
https://wiki.debian.org/LXD