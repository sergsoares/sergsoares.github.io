---
title: "Transfer files and SSH between private networks with wush"
draft: false
categories:
  - wush
  - wireguard
  - tailscale
date: 2024-09-06
---

A interesting app that I found recently navigating on [Reddit](https://reddit.com/) is wush.

[Wush](https://github.com/coder/wush) is a cli application to transfer files or open shell sessions through one Wireguard connection using the Public Tailscale [DERP Relays](https://tailscale.com/blog/how-tailscale-works#encrypted-tcp-relays-derp), it is made from coder that is the company behind the [Code server](https://github.com/coder/code-server).

Scenarios that wush can be useful (to avoid launch public intermediaries) and both sides have outbound internet connection:

- Copy file from AWS EC2 to a Proxmox VM
- Copy file between docker containers in different networks
- Copy file from work PC to a raspberry pi at home
- Upload data from EKS pods in a private VPC
- Sent public keys for servers with only GUI terminal access.

Let's show how wush works with a practical example:

### Install Wush in linux (both target and source servers)

This is a script to download and extract wush binary, but you can install using the [Wush bash script](https://github.com/coder/wush?tab=readme-ov-file#install) or download the specific release for your architecture in [wush releases](https://github.com/coder/wush/releases).

```shell
cd /tmp
export VERSION=0.1.2

wget "https://github.com/coder/wush/releases/download/v0.1.2/wush_${VERSION}_linux_386.tar.gz"

tar xzf "wush_${VERSION}_linux_386.tar.gz"

./wush
USAGE:
  wush <subcommand>

  wush 0.1.2 - peer-to-peer file transfers
  and shells
    - Start the wush server:
        $ wush serve
  
    - Open a shell to the wush host:
        $ wush ssh

    - Transfer files to the wush host using rsync:
        $ wush rsync
  local-file.txt :/path/to/remote/file

    - Copy a single file to the host:
        $ wush cp local-file.txt 

SUBCOMMANDS:
    cp         Transfer files.
    rsync      Transfer files over rsync.
    serve      Run the wush server.
    ssh        Open a shell.
    version    Show wush version.

OPTIONS:
      --version bool
          Print the version and exit.
```

If you want to install system-wide:

```shell
sudo install -o root -g root -m 0755 wush /usr/local/bin/wush
```


## Initialize wush in the target server

Install wush and execute wush in the target server to generate the keys and the auth key that will be used.

```shell
./wush serve
Picked DERP region  Toronto  as overlay home
Your auth key is:
  > 112v7Z17Mw6YFF2NmooVgBNo21Lwc1AkJ5cCvuvXhfSdJXHaun42s9P3HztHP5gXE9PAiq8UycWNEgRFUMYTHrbnxkh 
Use this key to authenticate other  wush  commands to this instance.
14:14:27 WireGuard is ready
14:14:28 SSH server enabled
14:14:28 File transfer server enabled
```


Now from any other device running wush you can:


### From another device open shell session to target server

```shell
# Provide auth key from target server
wush ssh
┃ Enter your Auth ID:                        
┃ > 

wush ssh
Auth information:
        > Server overlay STUN address:  Disabled 
        > Server overlay DERP home:     Toronto 
        > Server overlay public key:    [tYlsL] 
        > Server overlay auth key:      [3wHd2] 
Bringing WireGuard up..
WireGuard is ready!
Received peer
Peer active with relay  tor 
ubuntu $ 
```

## From another device transfer files to target server

Let's generate a file and copy that file using wush:

```shell
dd if=/dev/urandom of=precious_file.img count=1 bs=10M

ls -lh | grep preci
-rw-r--r-- 1 xubuntu xubuntu  10M Sep  3 11:25 precious_file.img
```

## After entering auth key from target server

```shell
wush cp precious_file.img
┃ Enter your Auth ID: 
┃ >  

# After auth key provided
wush cp precious_file.img
Auth information:
        > Server overlay STUN address:  Disabled 
        > Server overlay DERP home:     Toronto 
        > Server overlay public key:    [vAn/J] 
        > Server overlay auth key:      [97+UZ] 
Bringing WireGuard up..
WireGuard is ready!
Received peer
Peer active with relay  tor 
Uploading "precious_file.img"  15% |████████                                               | (1.6/10 MB, 397 kB/s) [3s:22s]

Uploading "precious_file.img"  70% |██████████████████████████████████████                 | (7.4/10 MB, 626 kB/s) [13s:4s]

Uploading "precious_file.img" 100% |████████████████████████████████████████████████████████| (10/10 MB, 594 kB/s)  
HTTP/1.1 200 OK
Content-Length: 32
Content-Type: text/plain; charset=utf-8
Date: Tue, 03 Sep 2024 14:26:59 GMT

File "precious_file.img" written
```

Then in the target server the file will appear in the workdir that wush serve initialized.

```shell
ls -lh | grep preci
-rw-r--r-- 1 root   root    10M Sep  3 14:26 precious_file.img
```
