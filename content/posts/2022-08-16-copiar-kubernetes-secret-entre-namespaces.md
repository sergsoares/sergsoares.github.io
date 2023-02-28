---
title: "Copiar kubernetes secret entre namespaces"
date: "2022-08-16"
categories: 
- k8s
---

Muitas vezes precisamos copiar um secret do kubernetes de um namespace para outro, visto que não temos a funcionalidade de secrets globais.

Para isso podemos executar o camando abaixo, que exporta o manifesto de um secret, substitui o nome do namespace no manifesto e aplica no cluster novamente:

``` shell
kubectl get secret aws --namespace=namespace1 -o yaml | sed 's/namespace: .*/namespace: namespace2/' | kubectl apply -f -
```
