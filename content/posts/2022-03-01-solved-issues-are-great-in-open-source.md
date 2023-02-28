---
title: "Solved issues are great in open source terraform"
date: "2022-03-01"
tags: 
- terraform
- oss
---

## Test
Errors be part of our day work at tech, but working with open source facilitate a lot, tools like terraform show us that community has power.

At work today received the below error in a "terraform plan":

```
Stack trace from the terraform-provider-aws_v3.74.0_x5 plugin:

panic: interface conversion: interface {} is nil, not *conns.AWSClient
```

And with a fast search I found a [Github Issue in Terraform](https://github.com/hashicorp/terraform-provider-aws/issues/20015) recommending update Terraform version.

Errors are not cool, but solved issues are.

Better yet using [Arkade](https://github.com/alexellis/arkade) it was an easy activity only doing:

```
arkade get terraform@1.0.9
```

And went back to my main activity.[](https://hashnode.com/@Sergsoares)
