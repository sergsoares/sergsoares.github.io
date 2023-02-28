---
title: "O que é o Rancher Desktop ?"
date: "2022-08-05"
categories: 
- rancher
---

O [Rancher Desktop](https://rancherdesktop.io) é uma aplicação multiplataforma feita pela [SUSE](https://www.suse.com/) que fornece mecanismos para gestão de containers e uma interface gráfica para  
a instalação de um cluster Kubernetes local.

As principais facilidades de utilizar o Rancher Desktop:

- O pacote de instalação já instala o [Nerdctl](https://github.com/containerd/nerdctl) para gestão das imagens e execução dos containers.
- Permite que as imagens criadas já sejam utilizadas dentro do Kubernetes.
- Permite implantar um cluster de Kubernetes utilizando a distribuição [K3S](https://k3s.io/) sendo possível escolher a versão que se desejada instalar através da interface gráfica.
- O fluxo para iniciar e finalizar o sistema não tem necessidade de scripts.
- Já instala um dashboard para o Kubernetes local.
- Possui uma ferramenta visual para criação de redirecionamento de porta entre o cluster o ambiente local.
- Cria o cluster com um ingress controller o Traefik, facilitando a exposição dos serviços.
- Efetua a criação de uma máquina virtual no MacOs e Windows de maneira transparente, sem necessidade de instalação de componentes extras.

A [documentação do Rancher Desktop](https://docs.rancherdesktop.io/how-to-guides/hello-world-example) é completa e conta com diversos tutoriais para se criar aplicações utilizando o cluster Kubernetes provisionado e a integração com outras aplicações.
