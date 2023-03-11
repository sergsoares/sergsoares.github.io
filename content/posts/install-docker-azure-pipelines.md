---
title: "Install Docker Azure Pipelines"
date: "2023-03-11"
categories: 
- azure-devops
---

# Install Docker inside Amazon Linux inside Azure Pipelines

Below is a simple step that verifies if docker exists validating existence of **docker.service**, if not it installs.

```yaml 
steps:
- script: |
    if systemctl --all --type service | grep -Fq 'docker'; then    
      echo "docker.service exists"
    else
      sudo yum install --assumeyes docker
      sudo usermod -a -G docker ec2-user
      sudo systemctl enable docker.service
      sudo systemctl start docker.service
      sudo systemctl status docker.service --no-pager
      docker version
      echo "Docker Installed"
    fi
  displayName: Install docker
```