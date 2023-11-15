---
title: Create a private cloud inside a VPS (Proxmox alternative)
draft: false
categories:
  - lxd
  - vps
  - lxc
  - lxdware
date: 2023-11-15T20:43:05.322Z
---
It is great to have a private cloud to create virtual machines and validate ideas for applications and infrastructure.

With Home Lab, we can use great projects like Proxmox, for most VPS providers, there is not an official image that can be used (beside it can be imported).

For those who, like me, want to create and destroy a lot of VMs that are used for several weeks in labs, the following tutorial provides an alternative using LXD and LXDware:

Requirements:
- VM with support for KVM
- 4GB or more of RAM 
- Debian 12 (OS that will be used)

Glossary:

- VM (a virtual machine created by LXD)
- server (where we will run the LXD daemon)
- local (computer that will be used to SSH inside server)
- LXD (is the daemon of LinuX Containers)
- LXC (is the command line for manage LinuX Containers Daemon)


### Prepare the server

Create a VPS (or use a bare metal server) of your choice, I will use a droplet in Digital Ocean with Debian 12.

Then ssh in it and check that KVM is working, then using kvm-ok we can validate if server support KVM:

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# apt update
root@debian-s-2vcpu-4gb-sfo3-01:~# apt install -y cpu-checker
root@debian-s-2vcpu-4gb-sfo3-01:~# kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
```

### Install components for lxd and virtualization

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# apt install --no-install-recommends -y lxd qemu-system qemu-system-x86 bridge-utils ovmf
```

### Initialize LXD server

We need to initialize lxd server, we will use all default configuration in that step.

```shell
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

### Run the first LXC VM to validate that it is working

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# lxc launch images:ubuntu/22.04/cloud vm01 --vm
If this is your first time running LXD on this machine, you should also run: lxd init

Creating ubuntu-vm
Retrieving image: rootfs: 50% (37.10MB/s)
Creating vm01
Starting vm01
```


### Install LXDware

Let's install [LXDware](https://lxdware.com) using a docker running inside a little VM.

Create a vm for LXDware:

```shell
$ lxc launch images:ubuntu/22.04/cloud lxdware --vm --config limits.memory=512MiB --config limits.cpu=1
```

#### Install docker dependency

Then access the LXDware vm and install docker:

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# lxc shell lxdware
root@lxdware:~# apt update && apt install -y docker.io
```

#### Create a container for LXDware:

```shell
root@lxdware:~# docker run -d --name dashboard -p 8000:80 -v ~/lxdware:/var/lxdware --restart=always lxdware/dashboard:3.8.0

# Then check that everything is ok inside the lxdware VM
root@lxdware:~# docker ps
```

### Access the VM's like a local network 

For that, we will use [sshuttle](https://github.com/sshuttle/sshuttle) that allow we to forward a CIDR acting like we are inside our host and access through secure SSH connection.

Lets discover which is the CIDR inside the server that host has access that we want access (if you changed default bridge change inside script):

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# ip route | grep lxdbr0 | awk '{print $1}'
10.254.155.0/24
```

With the CIDR we will create a command to forward traffic from our host to vm (passing by the server):

```
sudo sshuttle --dns -NHr <SERVER_USER>@<SERVER_IP> <CIDR>
```

Example using the ephemeral droplet that I created (Connected to server means success):
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

Now let's discover inside server the IP for LXDware vm

```shell
root@debian-s-2vcpu-4gb-sfo3-01:~# lxc list
+---------+---------+------------------------+-------------------------------------------------+-----------------+-----------+
|  NAME   |  STATE  |          IPV4          |                      IPV6                       |      TYPE       | SNAPSHOTS |
+---------+---------+------------------------+-------------------------------------------------+-----------------+-----------+
| lxdware | RUNNING | 172.17.0.1 (docker0)   | fd42:3898:ac14:5e8c:216:3eff:fe1a:6b53 (enp5s0) | VIRTUAL-MACHINE | 0         |
|         |         | 10.254.155.66 (enp5s0) |                                                 |                 |           |
+---------+---------+------------------------+-------------------------------------------------+-----------------+-----------+

```


And with the IP and the sshuttle tunnel we can access, in our case http://10.254.155.66:8000/

### Configure LXDware:

After access LXDware and create a user and password and made the login:

![](docs/images/lxd-registration.png)

And the main console will appear:

![](docs/images/dash.png)

Now let's add a new host for LXDware, and click in "here" link:

![](docs/images/add-host-detail.png)

Now for allowing LXDware to manage LXD server, we need to add the LXDware certificate to LXDServer that will be provided in the next screen:

![](docs/images/add-lxdware-crt.png)

For example, It can be done with the following commands (substitute the .crt content or create lxdware.crt by hand).

```shell
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

With the certificate allowed, we can connect from lxdware console inside lxd server using the IP of the server:

![](docs/images/add-with-ip.png)

![](docs/images/dash-with-access.png)

Now we can access virtual machines inside the host created host

![](docs/images/dash-virtual-machines.png)

![](docs/images/lxdware-vm.png)


### Troubleshooting

If when try to launch a VM you receive an error, check again the procedure to install dependencies and look for LXD logs

```shell
# Validating the logs from journal
$ journalctl -u lxd.service

# Or looking for logs in lxd.log
$ cat /var/log/lxd/lxd.log
```

### References

- [https://lxdware.com/installing-the-lxd-dashboard-using-the-docker-image/](https://lxdware.com/installing-the-lxd-dashboard-using-the-docker-image/)
- [https://documentation.ubuntu.com/lxd/en/latest/installing/](https://documentation.ubuntu.com/lxd/en/latest/installing/)
- [https://www.cyberciti.biz/faq/install-lxd-on-ubuntu-22-04-lts-using-apt-snap/](https://www.cyberciti.biz/faq/install-lxd-on-ubuntu-22-04-lts-using-apt-snap/)
- [https://wiki.debian.org/LXD](https://wiki.debian.org/LXD)

