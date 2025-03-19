---
title: Entr the agnostic file watcher
draft: false
categories:
  - tools
  - linux
date: 2025-03-18T20:48:23.688Z
---

There is some software that walks with us through our career after years, one of that software for me is entr.

Entr is a file watcher and helps to rerun commands when files change, but the best part of adopting entr is that you can use that with anything, reload .sql queries or Javascript unit tests, rebuilding Lua games, curling external APIs, recreating docker containers or for reloading daemons when configurations changes.

```sh
ls *.c | entr -rc myscript.sh
```

You can use it to execute a local script or powering entr with make (or a package.json or justfile) being a awesome match.

```Makefile
live:
	ls *.js | entr -c main.js
```

It allow you leave all prepared for only clone and execute the live reload:

```sh
$ make live
```

This is that type of software that improve your local development and the feedback loop, can't recommend enough have that in the toolset because neither all tools come with live reloads building.

For read more about the project at the [entr website](https://eradman.com/entrproject/) and look at [Github Repo](https://github.com/eradman/entr/).