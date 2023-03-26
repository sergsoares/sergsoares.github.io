---
title: "Configure Github Codespaces for Hugo Blog"
date: "2023-03-26"
categories: 
- github
- hugo
---

For use [Github Codespaces](https://github.com/features/codespaces) for edit Hugo blog i used the following configuration:

```json
{
  "name": "Sergsoares Blog",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "settings": {
    "terminal.integrated.defaultProfile.linux": "bash",
    "files.defaultLanguage": "markdown"
  },

  "extensions": [
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "editorconfig.editorconfig",
    "streetsidesoftware.code-spell-checker"
  ],

  "forwardPorts": [1313],

  "features": {
    "ghcr.io/devcontainers/features/hugo:1": {
        "extended": true
    }
  }
}
```

Thanks for Aaron with the post [Simplifying devcontainers with features](https://www.aaron-powell.com/posts/2023-01-11-simplifying-devcontainers-with-features/) and the [aaronpowell.github.io - devcontainer.json ](https://raw.githubusercontent.com/aaronpowell/aaronpowell.github.io/main/.devcontainer/devcontainer.json) file with correct features to avoid recreate hugo containers.


