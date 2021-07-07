[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Build Status][badge-build]][build-status]
[![GitHub tag (latest SemVer)][badge-semver]][releases-github]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Github Provider Version][badge-tf-gh]][releases-github-provider]
[![Join Slack][badge-slack]][slack]

# terraform-github-team

A [Terraform] module that offers a more convenient and tested way to provision and manage [GitHub teams].

**_This module supports Terraform v1, v0.15, v0.14, v0.13 as well as v0.12.9 and above
and is compatible with the Terraform Github Provider v4, v3 as well as v2.4 and above._**

- [Features](#features)
- [Getting Started](#getting-started)
- [Examples](#examples)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Features

This module supports the following resources:

- Team
- Nested Team
- Memberships
- Team Repositories

## Getting Started

```hcl
module "team" {
  source  = "mineiros-io/team/github"
  version = "~> 0.6.0"

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

For a complete example please see [examples/] directory.

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- **`module_depends_on`**: _(Optional `list(any)`)_

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

#### Main Resource Configuration

- **`name`**: **(Required `string`)**

  The name of the team.

- **`admin_repositories`**: _(Optional `set(string)`)_

  A list of repository names the current team should get admin (full) permission to.
  Default is `[]`.

- **`maintain_repositories`**: _(Optional `set(string)`)_

  A list of repository names the current team should get admin (maintain) permission to.
  Default is `[]`.

- **`push_repositories`**: _(Optional `set(string)`)_

  A list of repository names the current team should get push (read-write) permission to.
  Default is `[]`.

- **`triage_repositories`**: _(Optional `set(string)`)_

  A list of repository names the current team should get push (triage) permission to.
  Default is `[]`.

- **`pull_repositories`**: _(Optional `set(string)`)_

  A list of repository names the current team should get pull (read-only) permission to.
  Default is `[]`.

- **`maintainers`**: _(Optional `set(string)`)_

  A list of users that will be added to the current team with maintainer permissions.
  Default is `[]`.

- **`members`**: _(Optional `set(string)`)_

  A list of users that will be added to the current team with member permissions.
  Default is `[]`.

- **`description`**: _(Optional `string`)_

  A description of the team.
  Default is `""`.

- **`privacy`**: _(Optional `string`)_

  The level of privacy for the team. Must be one of `secret` or `closed`.
  Default is `"secret"`.

- **`parent_team_id`**: _(Optional `number`)_

  The ID of the parent team, if this is a nested team.
  Default is to create a root team without a parent.

- **`ldap_dn`**: _(Optional `string`)_

  The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise.
  Default is `null`.

## Module Attributes Reference

The following attributes are exported by the module:

- **`module_depends_on`**

  A list of external resources the module depends_on.

## External Documentation

- GitHub Provider Documentation
  - https://www.terraform.io/docs/providers/github/index.html

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

Mineiros is a [DevOps as a Service][homepage] company based in Berlin, Germany.
We offer commercial support for all of our projects and encourage you to reach out
if you have any questions or need help. Feel free to send us an email at [hello@mineiros.io]
or join our [Community Slack channel][slack].

We can also help you with:

- Terraform modules for all types of infrastructure such as VPCs, Docker clusters, databases,
  logging and monitoring, CI, etc.
- Consulting & training on AWS, Terraform and DevOps

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020 [Mineiros GmbH][homepage]

<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-github-team
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-github-team/workflows/CI/CD%20Pipeline/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-github-team.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x%20|0.15%20|0.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-github-team/actions
[releases-github]: https://github.com/mineiros-io/terraform-github-team/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gh]: https://img.shields.io/badge/GH-4%20|%203%20|%202.4+-F8991D.svg?logo=terraform
[releases-github-provider]: https://github.com/terraform-providers/terraform-provider-github/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-github-team/blob/master/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-github-team/tree/master/examples
[issues]: https://github.com/mineiros-io/terraform-github-team/issues
[license]: https://github.com/mineiros-io/terraform-github-team/blob/master/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-github-team/blob/master/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-github-team/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-github-team/blob/master/CONTRIBUTING.md
[github teams]: https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/organizing-members-into-teams
