---
title: A way to explore public container registries (like registry.k8s.io)
draft: false
categories:
  - k8s
  - container
date: 2025-03-09T19:04:23.688Z
---

I was needing an image for kubectl and even with a lot of community images, I was searching for one official for kubectl, after some research inside [Kubernetes discuss forum](https://discuss.kubernetes.io/t/registry-k8s-io-browse-search-interface/22984) I found that this image already exists inside registry.K8s.io.

But we don't have an official way to explore this registry, you can do that with a CLI but learned about [Registry Explorer](https://explore.ggcr.dev/) made by the community to search inside public registries. This is a web app that uses [Crane CLI](https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md) to interact with public registries.

![Registry explorer](images/explore.ggcr.dev.png)

With this we can explore registry.k8s.io for the image that we need ([registry.k8s.io/kubectl:v1.30.1)](https://explore.ggcr.dev/?image=registry.k8s.io%2Fkubectl:v1.30.1).

