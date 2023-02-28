---
title: "Restoring AMI with Packer"
date: "2022-03-30"
categories: 
- packer
---

We have several options to discover an AMI id to use in infra as code resources, but with [Packer from Hashicorp](https://www.packer.io/) it is simple as define a block that will recover based on a pattern the id.

Above the solution using filter to restore latest image id for a ubuntu 20.04 version.

```hcl
source "amazon-ebs" "ubuntu" {
  ami_name      = "azure-agent-image-v0.1"
  instance_type = "t3.micro"
  region        = "eu-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-*-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}
```

## References

- [https://lgallardo.com/2018/01/25/how-to-get-the-latest-ubuntu-ami/](https://lgallardo.com/2018/01/25/how-to-get-the-latest-ubuntu-ami/)
- [https://blog.gruntwork.io/locating-aws-ami-owner-id-and-image-name-for-packer-builds-7616fe46b49a](https://blog.gruntwork.io/locating-aws-ami-owner-id-and-image-name-for-packer-builds-7616fe46b49a)
