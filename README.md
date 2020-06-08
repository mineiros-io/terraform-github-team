[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://www.mineiros.io/?ref=terraform-github-team)

[![Build Status](https://mineiros.semaphoreci.com/badges/terraform-github-team/branches/master.svg?style=shields)](https://mineiros.semaphoreci.com/projects/terraform-github-team)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-github-team.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-github-team/releases)
[![license](https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12.20-623CE4.svg)](https://github.com/hashicorp/terraform/releases)
[<img src="https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack">](https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg)

# terraform-github-team

A [Terraform](https://www.terraform.io) 0.12 that offers a more convenient and tested way to provision and manage
[GitHub teams](https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/organizing-members-into-teams).

> This Module uses `for, for-each and dynamic nested blocks` that were introduced in Terraform 0.12.
> A common problem in Terraform configurations for versions 0.11 and earlier is dealing with situations where the number
> of values or resources is decided by a dynamic expression rather than a fixed count.
> You can now dynamically add and remove items from and to Lists without the necessity to render the whole list of
> resources again. Terraform will only add and remove the items you want it to.

- [Features](#features)
- [Getting Started](#getting-started)
- [Examples](#examples)
- [Makefile Targets](#makefile-targets)
- [Tests](#tests)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [License](#license)

## Features

This module uses the [Terraform GitHub provider v2.4](https://github.com/terraform-providers/terraform-provider-github/releases)
that supports the following resources:

- Team
- Nested Team
- Memberships
- Team Repositories

## Getting Started

```hcl
module "team" {
  source  = "mineiros-io/team/github"
  version = "0.0.1"

  name        = "DevOps"
  description = "The DevOps Team"
  privacy     = "secret"

  members = [
    "a-user",
    "b-user"
  ]

  maintainers = [
    "a-maintainer"
  ]

  push_repositories = [
    github_repository.repository.name,
  ]
}

resource "github_repository" "repository" {
  name   = "a-repository"
}
```

## Examples

For a complete example please see [examples](https://github.com/mineiros-io/terraform-github-team/tree/master/examples) directory.

## Makefile Targets

This repository comes with a handy
[Makefile](https://github.com/mineiros-io/terraform-github-team/blob/master/Makefile).
Run `make help` to see details on each available target.

## Tests

This modules ships with a [Makefile](https://github.com/mineiros-io/terraform-github-team/blob/master/Makefile)
that offers targets to execute the hooks and tests.

**Execute all pre-commit hooks with Docker:**

```bash
make docker/pre-commit-hooks
```

**Execute the Unit Test (deploy und undeploy the example):**

Please be aware, that in order to run the test you must provide GitHub credentials and an organization.
Running the tests will create and destroy real resources.

```bash
GITHUB_ORGANIZATION=YOUR_GITHUB_ORGANIZATION \
GITHUB_TOKEN=YOUR_GITHUB_TOKEN \
make docker/unit-tests
```

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)](https://semver.org/).

Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:

1. Use the `MAJOR` version for incompatible changes.
1. Use the `MINOR` version when adding functionality in a backwards compatible manner.
1. Use the `PATCH` version when introducing backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- In the context of initial development, backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is
  increased. (Initial development)
- In the context of pre-release, backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is
  increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service](https://www.mineiros.io/?ref=terraform-github-team) company based in Berlin, Germany. We offer commercial support
for all of our projects and encourage you to reach out if you have any questions or need help.
Feel free to send us an email at [hello@mineiros.io](mailto:hello@mineiros.io).

We can also help you with:

- Terraform Modules for all types of infrastructure such as VPC's, Docker clusters,
  databases, logging and monitoring, CI, etc.
- Consulting & Training on AWS, Terraform and DevOps.

## Reporting Issues

We use GitHub [Issues](https://github.com/mineiros-io/terraform-github-team/issues)
to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests](https://github.com/mineiros-io/terraform-github-team/pulls). If you’d like more information, please
see our [Contribution Guidelines](https://github.com/mineiros-io/terraform-github-team/blob/master/CONTRIBUTING.md).

## License

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE](https://github.com/mineiros-io/terraform-github-team/blob/master/LICENSE) for full details.

Copyright &copy; 2020 Mineiros GmbH
