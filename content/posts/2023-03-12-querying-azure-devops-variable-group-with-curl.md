---
title: Querying Azure DevOps Variable group with Curl
date: 2023-03-12T00:09:45.712Z
description: azure-devops
draft: false
categories:
  - azure-devops
---
W﻿e can use a curl with our PAT token to query Azure DevOps Variable groups, and add filter like groupName for find specific variable groups.

```
PAT=<PAT_TOKEN>
ORG_NAME=<NAME_OF_ORGANIZATION>
PROJECT_NAME=<NAME_OF_PROJECT>
GROUP_NAME=<NAME_OF_THE_GROUP>

curl -u :${PAT} 'https://dev.azure.com/{ORG_NAME}/{PROJECT_NAME}/_apis/distributedtask/variablegroups?groupName=${GROUP_NAME}'
```