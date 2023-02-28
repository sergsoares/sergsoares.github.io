---
title: "Show more lines in a grep filter."
date: "2022-09-15"
categories: 
- linux
---

Grep is an awesome linux app that is used for filtering text data, but sometimes we want more that only the lines of the match text.

```
grep -A 1 # got 1 line after match
grep -B 1 # got 1 line before match
grep -C 1 # got before and after
```
