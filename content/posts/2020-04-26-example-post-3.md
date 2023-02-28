---
title: "Como utilizar docker como ambiente de trabalho"
date: "2020-04-26"
description: "Example Lazy Load Image"
categories: 
- docker
---

Sempre achei interessante a ideia de rodar aplicações gráficas utilizando container e poder facilitar a replicação delas em diferentes locais.

Pesquisando anos atrás formas de utilizar o docker para esse fim vi posts excelentes como do [Somatório - Rodando aplicações GUI em Docker](http://somatorio.org/pt-br/post/rodando-aplicacoes-gui-em-docker/) e da [Jessie - Docker Containers on the Desktop](https://blog.jessfraz.com/post/docker-containers-on-the-desktop/).

Entretanto esses cenários são para aplicações específicas, não para o ambiente de trabalho inteiro, recentemente pesquisando formas criar um home lab privado e implicações de segurança pensei em criar uma VM com interface gráfica na cloud:

- [Running Ubuntu Desktop GUI (AWS EC2 Instance) on Windows](https://medium.com/@0xson/running-ubuntu-desktop-gui-aws-ec2-instance-on-windows-3d4d070da434)
- [Your desktop on Google Cloud Platform](https://medium.com/google-cloud/linux-gui-on-the-google-cloud-platform-800719ab27c5)

Porém o que mais me surpreendeu foi o [Running GUI apps securely in docker (sandbox)](https://medium.com/@techupbusiness/running-gui-apps-securely-in-docker-sandbox-5d945288929b) que tem um repositório [docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop) muito bem organizado e trás como uma opção criar um container com ambiente gráfico Lxde/Lxqt.

Nos testes tanto local quanto em uma VM na GCP funcionou muito bem a navegação e edição de código através dele, o docker in docker funcionou normalmente e ajustando a configuração de resolução permitiu ter uma experiência agradável de uso no [VNC Viewer](https://www.realvnc.com/pt/connect/download/viewer/)

Pretendo criar um fork do projeto e customizar a image para usos próprios.
