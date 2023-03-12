---
title: Using Jinja2 to play with Template Engine
draft: false
categories:
  - iac
  - python
date: 2023-03-12T03:14:03.684Z
---
Imagine the scenario, we want to create multiple S3 buckets using the Cloudformation block below:

```
# template.yml
Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: my-bucket-1
```

But we don't want to repeat and hardcode values inside the manifest, one alternative is using a template engine to allow variables and loops to generate the final manifest.

For example, we will use [Jinja2 Template Engine][jinja2] with a CLI tool named [Jinja2 CLI][1] to be easy to execute the templates.

$﻿ python3 -m venv venv
$ source venv/bin/activate
$﻿ pip3 install jinja2-cli

Now is possible to create a jinja2 template with a parametrized name variable following [Jinja2 Syntax](https://jinja.palletsprojects.com/en/3.1.x/templates/):

```
# template.j2
Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: {{ name }}
```

And with our dependencies installed, we can execute it to render the template.

```
$ jinja2 template.j2 -D name=my-api-bucket
```

The output was a rendered template with my-api-bucket, But if we want to create 5 different buckets ? First, we will define our variables in a JSON file. 

```json
# names.json
{
  "names": [
    "backend-s3",
    "nextjs",
    "landpage",
    "blog",
    "reports"
  ]
}
```

And create a jinja2 template with a for loop to iterate through the list creating an S3 block for each name:

```
# 
{% for item in names %}
Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: {{ item }}
{% endfor %}
```

Below is the command to render the template passing a JSON file with variables:

```
$ cat names.json | jinja2 parametrized.j2 
```

With that, we can receive the output for our final manifest.

```
Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: backend-s3

Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: nextjs

Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: landpage

Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: blog

Resources:
  S3Bucket:
    Type: 'AWS::S3::Bucket'
    DeletionPolicy: Retain
    Properties:
      BucketName: reports
```

With this simple case, we saw how to use jinja2-cli to iterate to generate dynamic configuration and declarative files.


[1]: https://github.com/mattrobenolt/jinja2-cli
[jinja2]: https://palletsprojects.com/p/jinja/