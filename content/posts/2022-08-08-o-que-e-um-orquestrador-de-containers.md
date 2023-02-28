---
title: "O que é um orquestrador de containers ?"
date: "2022-08-08"
categories: 
- k8s
---

Um orquestrador é um software desenvolvido para gerenciar containers em um ambiente distribuído entre máquinas virtuais, sendo o componente de controle nesse cenário distribuído suas principais características são:

- Permitir distribuir a carga de trabalho entre as diversas máquinas.
- Garantir que o ciclo de vida do container seja feito com sucesso (desde sua criação até finalização).
- Manter a gestão dos recursos entre as diversas máquinas, permitindo que um container que não tem recurso disponível na máquina A seja criado na máquina B.

Entre as opções disponíveis temos os orquestradores próprios das cloud's como [AWS ECS](https://aws.amazon.com/pt/ecs/), [Azure Container Instance](https://azure.microsoft.com/pt-br/services/container-instances/#getting-started) e o [Google Cloud Run](https://cloud.google.com/run?hl=pt-br).

Já entre os orquestradores open source (que podem também ter opções gerenciadas na nuvem) temos o [Kubernetes](https://kubernetes.io/pt-br/), [Nomad](https://www.nomadproject.io/), [Docker Swarm](https://docs.docker.com/engine/swarm/) e [OpenShift](https://www.redhat.com/pt-br/technologies/cloud-computing/openshift).
