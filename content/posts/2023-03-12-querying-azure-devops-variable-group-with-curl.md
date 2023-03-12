---
title: Querying Azure DevOps Variable group with Curl
date: 2023-03-12T00:09:45.712Z
description: azure-devops
---
W﻿e can use a curl with our PAT token to query Azure DevOps Variable groups, and add filter like groupName for find specific variable groups.

`﻿``
curl -u :${PAT} 'https://dev.azure.com/{org}/{project}/_apis/distributedtask/variablegroups?groupName=${GROUP_A}'
`﻿``