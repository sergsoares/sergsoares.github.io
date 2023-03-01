---
title: "Installing Binaries"
date: 2023-02-28T08:41:01-03:00
draft: true
---

Most part opensource tools (mainly made in Go & Rust) are distributed as Binaries that can be downloaded from Github Release page.

Here there are some snippets for install the most popular options.

## When you know that content will be extracted with same name as binary.
```
wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz -O - |\
tar xz && mv gotty /usr/bin/gotty
```

##  A more build in way to install binaries, where can determine user, group and permissions and destination. 
```
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
