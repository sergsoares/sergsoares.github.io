---
title: Install Golang in Linux
draft: false
categories:
  - golang
  - linux
date: 2023-11-19T18:55:24.288Z
---

Procedure to install Golang with one script from specific version (based on https://go.dev/doc/install).

```shell
#!/bin/bash
VERSION=1.21.4

cd /tmp
curl -LO "https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"
rm -rf /usr/local/go && tar -C /usr/local -xzf "go${VERSION}.linux-amd64.tar.gz"
export PATH=$PATH:/usr/local/go/bin
go version
```