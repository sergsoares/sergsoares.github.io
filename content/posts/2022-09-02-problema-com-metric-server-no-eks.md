---
title: "Metric server não respondendo no EKS"
date: "2022-09-02"
categories: 
- eks
- k8s
- aws
---

Após configuração do cluster de Kubernetes usando o EKS e instalação do [metric server](https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html), ao se executar o comando para obter o uso de recursos atuais dos nodes, o seguinte erro aparece:

```
$ kubectl top nodes
error: metrics not available yet ...
```

Após verificar as issues do GitHub para entender melhor o cenários, a mais relevante foi [EKS v1.22 "Error from server (ServiceUnavailable): the server is currently unable to handle the request (get nodes.metrics.k8s.io)](https://github.com/kubernetes-sigs/metrics-server/issues/1024) repoduzindo o mesmo cenário.

Seguindo o fluxo de troubleshooting recomendado foi possível verificar o erro dentro do componente, onde o control plane não consegue se comunicar com com a api de métricas do node:

```
$ kubectl get apiservices.apiregistration.k8s.io
v1beta1.metrics.k8s.io ...

$ kubectl describe apiservices v1beta1.metrics.k8s.io
Message:               failing or missing response from https://10.46.5.75:4443/apis/metrics.k8s.io/v1beta1: Get "https://10.46.5.75:4443/apis/metrics.k8s.io/v1beta1": net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
...
```

Após confirmado, foi feito a liberação para o Control Plane conseguir acessar a porta 4443 do Node Group via Security Group, resolvendo o problema e conseguindo obter as métricas de nodes e pods.
