---
title: Ideas for projects related with Cloud/K8S apps
draft: false
categories:
  - code
  - infra-as-a-code
date: 2025-03-06T09:38:23.688Z
---

As a tech person that started my carrer as a developer and faded into to Sysadmin/SRE roles because my proximity with linux and open source I really like programming and was thinking about how do it more.

I was thinking about this list with projects around the tooling that I use in my daily work because it can improve my mental model around infrastructure and programming, but of course, you can create a micro saas, poke with functional programming, contribute to open source, or create games.

## Projects to code

- [Krew plugin](https://github.com/replicatedhq/krew-plugin-template) - Create a krew plugin and learn how it can integrate in kubectl and how to work with K8S API.

- [Terraform Provider](https://developer.hashicorp.com/terraform/tutorials/providers-plugin-framework/providers-plugin-framework-provider) - Code a new terraform provider to allow other interact with a service that only provide REST API to define the state.

- [CDK extension](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_appconfig.Extension.html) - Create a extension for CDK can be helpful to understand how the building blocks are made and extend CDK IaC for another systems.

- [Prometheus Exporter](https://prometheus.io/docs/instrumenting/writing_exporters/) - Prometheus is the CNCF metric database for containers world, create an exporter that fetches data from systems that do not provide any metrics (and you can't change code to create /metrics)

- [Azure DevOps Plugin](https://marketplace.visualstudio.com/azuredevops) - Working years with Azure Devops really felt that a lot of plugins could be created for the platform.

- [Drone.io Plugin](https://docs.drone.io/plugins/tutorials/golang/) - Drone was a brief air for self-hosted CI/CD, besides the limitations around it, it is very easy to start to use, and the plugin system is easy too.

- [Woodpecker CI Plugin](https://woodpecker-ci.org/docs/usage/plugins/creating-plugins) - Woodpecker CI is a fork of Drone.io that is gaining popularity and has the same great plugin workflow.

- [Github Actions (Custom Action)](https://docs.github.com/en/actions/sharing-automations/creating-actions/creating-a-javascript-action) - Create your own Github Actions task for apps that aren't supported or custom workflows reducing Github boilerplate.

- [Backstage Plugin](https://backstage.io/docs/plugins/) - Working with IdPs (Internal Developer Platforms) can require integration with multiple systems to keep the workflow lean, and sometimes not all systems have support for Backstage steps and actions.

- [ArgoCD Plugin Generator](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Generators-Plugin/) - Argo has a huge influence in the Gitops world for Kubernetes one of the ways you can extend its usage with code is to create a custom generator allowing control over the way that argo apps will be created.

- [VScode plugin](https://code.visualstudio.com/api/get-started/your-first-extension) - VScode is versatile and works well, creating plugins to facilitate development or test systems can be a good learning process.

- [VScode Macro Custom configurations](https://github.com/exceedsystem/vscode-macros) - Another way that can be more fun is to extend macros and plugins for Vscode and speed up your editing skills.

- [Open Telemetry Custom Collector](https://opentelemetry.io/docs/collector/custom-collector/) - Improve observability and mechanisms for local apps can be a good match for a customized open telemetry collector.

- [Cloudformation Custom Resources](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-custom-resources.html) - Custom resources with Cloudformation using lambda to manipulate the state can improve the understanding of infrastructure as code state management.

## Ideas for modules to be exposed

- [Terraform Module](https://developer.hashicorp.com/terraform/language/modules) - Creating modules for Terraform to abstract a lot of resources with a set of parameters can be a good exercise.

- [Ansible Playbook](https://docs.ansible.com/ansible/latest/getting_started/get_started_playbook.html) - Another infrastructure as code package that can be created to facilitate others is Ansible playbooks.

- [Docker Image](https://docs.docker.com/get-started/introduction/build-and-push-first-image/) - Container images are the groundwork of Cloud Native Apps creating your own for custom workflows can be useful.

- [Helm Chart](https://helm.sh/docs/topics/chart_repository/) - Charts are the principal way to distribute Kubernetes apps, deciding how to abstract too many configuration options for the users can be a challenge to practice too.

And have fun at final =)