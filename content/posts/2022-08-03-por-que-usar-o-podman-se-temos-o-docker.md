---
title: "Por que usar o podman se temos o Docker ?"
date: "2022-08-03"
categories: 
- podman
- container
---

O Podman é uma ferramenta de linha de comando para execução de containers, sendo uma alternativa ao docker, mas quais são suas principais características?

- Daemonless - O Docker é uma ferramenta que precisa ser instalada com privilégios de usuário root, enquanto o podman por ser daemonless não precisa desses mesmos privilégios facilitando o seu uso.

- Rootless - O podman aplica o conceito de rootless para a execução dos seus containers reduzindo a superfície de ataque através de um container infectado ao host, atualmente já temos o [suporte no docker nas novas versões](https://docs.docker.com/engine/security/rootless/).

Vale a pena também olha a a [documentação do podman](https://docs.podman.io/en/latest/Introduction.html) que conta com excelentes explicações a respeito do uso de containers e dos conceitos envolvidos.
