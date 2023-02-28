---
title: "O que OCI tem a ver com a ver com containers ?"
date: "2022-08-04"
categories: 
- oci
- container
---

Creio que já viu em blogs técnicos, documentações e posts no dia a dia de trabalho o termo OCI sempre relacionado a docker e containers, mas o que de fato é OCI e como ele tem relação com docker/containers ?

OCI é a sigla para Open Container Initiative que seria uma organização criada por empresas relacionados a tecnologia de container como a Docker, Inc (empresa por trás da ferramenta docker) e que tem como objetivo prover um padrão para:

- Especificação do runtime (ambiente de execução) dos containers.
- Especificação para o padrão de images que deve ser utilizado.

O foco seria garantir a interoperabilidade de images criadas por outras ferramentas que seguem o padrão OCI permitindo que images criadas com docker possa ser utilizadas em outros container engines como podman por exemplo.

Para obter mais informações, é possível consultar o site do [Open Container Initiative](https://opencontainers.org/).
