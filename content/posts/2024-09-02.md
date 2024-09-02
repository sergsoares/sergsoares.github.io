---
title: "Create a free startpage using Flame with Fly.io"
draft: false
categories:
  - flyio
  - flame
  - self-hosted
date: 2024-09-02
---

TLDR: The need for a startpage accessible public/private and cross devices without exposing homelab publicly, decided to use [Flame Startpage](https://github.com/pawelmalak/flame) and provisioned by [Fly.io](https://fly.io/) inside the free tier.

![](images/flame-dash.png)

## Motivation

One useful application to have inside homelab is a startpage (like that intranet page with several links for all the applications used internally by a company) for add all quick links for the several systems that we manage and useful web apps like password manager, news websites and others.

I was without a startpage for personal content but remeber about [Flame startpage](https://github.com/pawelmalak/flame) a minimal start page that I found in [Awesome Homelab](https://www.awesome-homelab.com/).

And in my case, I want a startpage to use online for access on another devices for most of my IT work and wasn't interested in expose it from my homelab, even with Tailscale in some cases I am in a PC without the app installed/configured.

And flame match some criterias for my usecase:

- Support for live edit the links, not from yaml/config files (It create friction to edit outside VPN access or Github auth for trigger cicd worklows).

- Easy host with sqlite database (avoiding apps that need full databases services).

- Basic login auth buildin for separate public and private links.

Then why not use the Fly.io to create the app and use the free tier (credits allowance using shared-cpu-1x256MB ram) for avoid more costs.

## Deploying Flame inside Fly.io

Create a account in [Fly.io](https://fly.io/) and install the [Fly.io CLI](https://fly.io/docs/flyctl/) and do the cli login with:

```shell
fly auth login
```

After that we can create a folder for the 2 files that we will needed, first create the fly.toml that we will define all base configurations for our Fly App.

```toml
app = 'startpage-example'
primary_region = 'iad' # Cheaper region in Fly.io

[build]

[[mounts]]
  source = 'flame_data'
  destination = '/app/data' # Folder used by Flame

[http_service]
  internal_port = 5005
  force_https = true
  auto_stop_machines = 'stop'
  auto_start_machines = true
  min_machines_running = 0
  processes = ['app']

[[vm]]
  memory = '256mb'
  cpu_kind = 'shared'
  cpus = 1
```

Then add Dockerfile file for specific Flame image (I prefer define specific version but can be used latest).

```Dockerfile
FROM pawelmalak/flame:2.3.1

EXPOSE 5005
```

With both files created, in the same folder we can run:

```shell
fly deploy
```

It will create the Fly application and create a new 1GB volume to be used by the fly machine in the same region.

After that Fly create a domain fly.dev that give you access for the page.

It is working but for edit the page we need define the password for Flame.

In the flame documentation there is a variable that can be defined for specify a password for flame, lets use fly cli to define that secret [Fly Secrets Documentation](https://fly.io/docs/apps/secrets/):

```shell
fly secrets set PASSWORD=mysecretpassword
```

A deploy will be done and the password can be used to edit your dashboard in /settings inside the domain created to auth.

## Volume and Backups

Fly manage volumes for us and provide volume snapshots [Fly Volume Snapshots](https://fly.io/docs/flyctl/volumes-snapshots/) to restore.

In case you want export the data (or create backups) inside the volumes it is possible to use SFTP commands that are available in Fly to zip the data:

```shell
# This command will open a interactive shell.
flyctl ssh sftp shell

# Inside the sftp shell is possible zip the data folder.
get /app/data flame-data.zip
```