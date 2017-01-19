# terraform aws recipes

A set of recipes that helps to get started with running docker based Microservices using aws infrastructure.

This repo helps creating microservices that leverages ECS cluster for running docker images, using ALB for load balancing, KMS security, Cloudwatch for logs.

## How to use this?

Refer to [pageuppeopleorg/infra-bootstrap](https://github.com/PageUpPeopleOrg/infra-bootstrap) for usage.


## Preferred way of using this.

The recommended way is to use this repo as a submodule for the reason that it allows the recipes to be centralised.
It forces people to come up with better architectures and keep the source of truth upto date.

### How to add submodule
` git submodule add git@github.com:PageUpPeopleOrg/terraform-aws-recipes.git recipes`
