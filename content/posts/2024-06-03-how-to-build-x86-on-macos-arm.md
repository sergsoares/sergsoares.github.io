---
title: How to Build x86 Images on macOS ARM
draft: false
categories:
  - colima
  - container
date: 2024-06-03
---

## How to Build x86 Images on macOS ARM

Although it may not be the best option, one of the ways I build x86 images on my personal Mac M1 is by using Colima (https://github.com/abiosoft/colima).

Colima is a virtualization layer that uses the Lima VM, allowing easy usage of containers on macOS ARM. It provides a great experience as an easy alternative to Docker Desktop, and it works entirely from the CLI.

One way to use Colima is in emulation mode. This mode can be enabled by starting a Colima instance using the --arch flag.

```shell
$ colima start --arch x86_64
```

After that, it is possible to enter the VM using colima ssh. A great feature of Colima is that it mounts your host disk inside the VM, making it practical to access your files without needing to worry about mounting folders.

As Colima already opens the current working directory, if you have a Dockerfile inside the folder, you can run:

```shell
$ docker build -t app .
```

And everything works. The downside of this approach is that emulation is very, very slow. Even for fast build processes, like building a Golang binary, it takes minutes to finish. However, it gets the job done.
