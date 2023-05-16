---
title: A trick snippet for easy Terraform target apply
draft: true
categories:
  - terraform
date: 2023-05-16T23:55:17.755Z
---
A recurrent task that is needed when we manage infrastructure with Terraform is to apply only a part of the template, to be faster to feedback, or to avoid dealing temporarily with some resources.

Doing a lot of targets apply recently I create a snippet for Make to simplify selecting a specific resource with an interactive menu.

```Makefile
target:
	SELECTED=`cat main.tf | grep resource | tr -d '"' | awk '{ print $$2 "."  $$3 }' | fzf` ; \
	terraform apply -target=$$SELECTED
```

In the script, we can extract the resource name using a combo of CLI apps and pass it as a parameter for *fzf* that creates a menu for us.

With the selected option we can enter to apply without keep copying and pasting with the target option