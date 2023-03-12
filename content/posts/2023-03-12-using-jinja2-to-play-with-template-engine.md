---
title: Using Jinja2 to play with Template Engine
draft: true
categories:
  - iac
  - python
date: 2023-03-12T03:14:03.684Z
---
T﻿emplate engine is a core part of actual usage of infrastructure as a code.

L﻿et's create a simple repo for play with Jinja2.

$﻿ python3 -m venv venv
$ source venv/bin/activate
$﻿ pip3 install jinja2

I﻿magine the scenario, we want to create multiples S3 buckets using Cloudformation but we doesn't want to create 