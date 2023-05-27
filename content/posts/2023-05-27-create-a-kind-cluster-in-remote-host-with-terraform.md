---
title: Create a Kind cluster in a remote host with Terraform
draft: false
categories:
  - kind
  - kubernetes
  - terraform
  - golang
  - docker
date: 2023-05-27T06:45:06.674Z
---
Kind is an app used for creating development and single command installation Kubernetes clusters, using a Docker container that allows us to quickly create a new Kubernetes cluster.

Kind has a simple CLI to create the cluster but sometimes we want to iterate to create a cluster or back fast to a configuration state.

For it is possible to use Terraform to manage Kind cluster with the provider [Terraform provider - tehcyx/kind](https://registry.terraform.io/providers/tehcyx/kind/0.1.0)  that is simple to create the Kind cluster, the simplest use of the provider:

```hcl
provider "kind" {}

resource "kind_cluster" "default" {
    name = "test-cluster"
}
```

Kind inside the lib uses Docker CLI to manage container [Github - kubernetes-sigs/kind - provider.go](https://github.com/kubernetes-sigs/kind/blob/main/pkg/cluster/internal/providers/docker/provider.go) and Docker CLI interact with Docker Daemon.

Then Terraform uses Kind lib that creates the cluster using Docker daemon inside the host that runs Terraform, but if I want to create a Kind cluster inside a remote host?

For it Docker CLI has the option to define an environment variable named DOCKER_HOST to determine the docker daemon target for CLI [Docker CLI - options](https://docs.docker.com/engine/reference/commandline/cli/#options)

With it, we can configure an SSH KEY with another host, an example of how to do this is [Use Remote Docker Host With SSH](https://blog.programster.org/use-remote-docker-host-with-ssh).

With SSH configured is possible to define the DOCKER_HOST like that:

```bash
export DOCKER_HOST=ssh://<SSH_USER>@<SSH_HOST>
```

And configure the Terraform resource with parameters that will allow us to connect to Kubernetes from outside the host (The way that Kind expected by default):

```hcl
resource "kind_cluster" "default" {
  name           = "remote-cluster"
  wait_for_ready = true

  kind_config {
      kind        = "Cluster"
      api_version = "kind.x-k8s.io/v1alpha4"

      #https://kind.sigs.k8s.io/docs/user/configuration/#api-server
      networking {
        api_server_address = "0.0.0.0" # Allow connections outside the host.
        api_server_port = 6443 # Fix ApiServerPort
      }
      
      node {
          role = "control-plane"

          kubeadm_config_patches = [
              "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
          ]

          extra_port_mappings {
              container_port = 80
              host_port      = 80
          }

          extra_port_mappings {
              container_port = 443
              host_port      = 443
          }
      }
  }
}
```

Then after terraform apply (in a host with docker already installed), it is possible to change the kubeconfig generated in ~/.kube/config for the cluster, commenting certificate-authority-data and add insecure-skip-tls-verify to access the cluster.

```yaml
...
- cluster:
    #certificate-authority-data: <ommited...>
    server: https://<SSH_HOST>:6443
    insecure-skip-tls-verify: true
  name: remote-cluster
...
```
