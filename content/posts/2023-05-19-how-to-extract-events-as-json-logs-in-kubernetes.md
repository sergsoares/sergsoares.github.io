---
title: How to extract events as JSON logs in Kubernetes
draft: false
categories:
  - kubernetes
  - logs
date: 2023-05-19T03:41:45.173Z
---
Recently I discovered a tool that extracts [k8s-event-logger](https://artifacthub.io/packages/helm/deliveryhero/k8s-event-logger) and wanna try to use to improve monitoring against k8s events.

Let's create a cluster and install our package:

```
$ helm install k8s-event-logger deliveryhero/k8s-event-logger
```

After that, we can look for logs using the command:

```
$ kubectl logs deploy/k8s-event-logger
```

With that we can see several lines of JSON logs that represent our k8s events, let's take a look at the data structure that was created:

```json
{
  "metadata": {
    "name": "metrics-server-668d979685-r9nwb.17606d7fb1965107",
    "namespace": "kube-system",
    "uid": "7fbb140a-d57c-41f6-b746-9fd6d5667eb0",
    "resourceVersion": "5462",
    "creationTimestamp": "2023-05-19T03:24:15Z",
    "managedFields": [
      {
        "manager": "k3s",
        "operation": "Update",
        "apiVersion": "v1",
        "time": "2023-05-19T03:24:15Z",
        "fieldsType": "FieldsV1",
        "fieldsV1": {
          "f:count": {},
          "f:firstTimestamp": {},
          "f:involvedObject": {},
          "f:lastTimestamp": {},
          "f:message": {},
          "f:reason": {},
          "f:source": {
            "f:component": {},
            "f:host": {}
          },
          "f:type": {}
        }
      }
    ]
  },
  "involvedObject": {
    "kind": "Pod",
    "namespace": "kube-system",
    "name": "metrics-server-668d979685-r9nwb",
    "uid": "78138cda-8165-4f38-801e-7878273dc872",
    "apiVersion": "v1",
    "resourceVersion": "445",
    "fieldPath": "spec.containers{metrics-server}"
  },
  "reason": "Unhealthy",
  "message": "Readiness probe failed: HTTP probe failed with statuscode: 500",
  "source": {
    "component": "kubelet",
    "host": "colima"
  },
  "firstTimestamp": "2023-05-19T03:24:15Z",
  "lastTimestamp": "2023-05-19T03:24:30Z",
  "count": 10,
  "type": "Warning",
  "eventTime": null,
  "reportingComponent": "",
  "reportingInstance": ""
}
```

Looking for a specific line we can how more about the structure that k8s-event-logger will give us and think some insights about it data:

- Alerts based on count size (if some event occurs several times it can represent a bad behavior inside the cluster)
- We can filter by .type property for got a warning and other noninfo events.
- Filter by specific reasons that can be used for self-healing workflows
- Had the message/involved object with type and reason is suitable for creating valuable alerts.

Good app for more contextualized events alerts (and to long term storage of cluster events).