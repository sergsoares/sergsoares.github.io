---
title: "A good start template for Makefile"
date: "2023-01-31"
categories: 
- make
---

It is a simple template that i use frequently to initiate projects with Makefile.

``` make
.PHONY: help

# Show this help.
help:
    @awk '/^#/{c=substr($$0,3);next}c&&/^\[\[:alpha:\]\]\[\[:alnum:\]\_-\]+:/{print substr($$1,1,index($$1,":")),c}1{c=0}' $(MAKEFILE\_LIST) | column -s: -t

# Turn on docker-compose environment.
up: 
    @docker-compose up -d

# Turn on docker-compose environment.
down: 
    @docker-compose down -d
```

It use a help recipe in Make that process the comments on top of each task, providing descriptions for tasks and allowing discovery from other that use the project.

Then when some run make inside the project, will generate the following output:

```
$ make
help   Show this help.
up     Turn on docker-compose environment.
down   Turn on docker-compose environment
```