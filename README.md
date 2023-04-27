[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-github-team)

[![Build Status](https://github.com/mineiros-io/terraform-github-team/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/mineiros-io/terraform-github-team/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-github-team.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-github-team/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Github Provider Version](https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-github/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-github-team

A [Terraform] module that offers a more convenient and tested way to provision and manage [GitHub teams].

**_This module supports Terraform v1.x and is compatible with the Official Terraform GitHub Provider v4.x from `integrations/github`._**

**Attention: This module is incompatible with the Hashicorp GitHub Provider! The latest version of this module supporting `hashicorp/github` provider is `~> 0.6.0`**


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Extended Resource Configuration](#extended-resource-configuration)
    - [Team membership](#team-membership)
    - [Team repository access](#team-repository-access)
  - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [GitHub Provider Documentation](#github-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [GitHub as Code](#github-as-code)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module supports the following resources:

- Team
- Nested Team
- Memberships
- Team Repositories

## Getting Started

```hcl
module "team" {
  source  = "mineiros-io/team/github"
  version = "~> 0.8.0"

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

provider "github" {}

terraform {
  required_version = "~> 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Main Resource Configuration

- [**`name`**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

  The name of the team.

- [**`description`**](#var-description): *(Optional `string`)*<a name="var-description"></a>

  A description of the team.

  Default is `""`.

- [**`privacy`**](#var-privacy): *(Optional `string`)*<a name="var-privacy"></a>

  The level of privacy for the team. Must be one of `secret` or `closed`.

  Default is `"secret"`.

- [**`parent_team_id`**](#var-parent_team_id): *(Optional `number`)*<a name="var-parent_team_id"></a>

  The ID of the parent team, if this is a nested team.

  Default is to create a root team without a parent.

- [**`ldap_dn`**](#var-ldap_dn): *(Optional `string`)*<a name="var-ldap_dn"></a>

  The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise.

- [**`create_default_maintainer`**](#var-create_default_maintainer): *(Optional `bool`)*<a name="var-create_default_maintainer"></a>

  Adds the creating user to the team when set to `true`."

  Default is `false`.

### Extended Resource Configuration

#### Team membership

- [**`maintainers`**](#var-maintainers): *(Optional `set(string)`)*<a name="var-maintainers"></a>

  A list of users that will be added to the current team with maintainer permissions.

  Default is `[]`.

- [**`members`**](#var-members): *(Optional `set(string)`)*<a name="var-members"></a>

  A list of users that will be added to the current team with member permissions.

  Default is `[]`.

#### Team repository access

- [**`admin_repositories`**](#var-admin_repositories): *(Optional `set(string)`)*<a name="var-admin_repositories"></a>

  A list of repository names the current team should get [admin](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.

  Default is `[]`.

- [**`maintain_repositories`**](#var-maintain_repositories): *(Optional `set(string)`)*<a name="var-maintain_repositories"></a>

  A list of repository names the current team should get [maintain](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.

  Default is `[]`.

- [**`push_repositories`**](#var-push_repositories): *(Optional `set(string)`)*<a name="var-push_repositories"></a>

  A list of repository names the current team should get [push (read-write)](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.

  Default is `[]`.

- [**`triage_repositories`**](#var-triage_repositories): *(Optional `set(string)`)*<a name="var-triage_repositories"></a>

  A list of repository names the current team should get [push (triage)](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.

  Default is `[]`.

- [**`pull_repositories`**](#var-pull_repositories): *(Optional `set(string)`)*<a name="var-pull_repositories"></a>

  A list of repository names the current team should get [pull (read-only)](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.

  Default is `[]`.

### Module Configuration

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(object)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_use_members`**](#var-module_use_members): *(Optional `bool`)*<a name="var-module_use_members"></a>

  Wether to use github_team_members or github_team_membership.

  Default is `false`.

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`id`**](#output-id): *(`string`)*<a name="output-id"></a>

  The ID of the team.

- [**`name`**](#output-name): *(`string`)*<a name="output-name"></a>

  The name of the team.

- [**`slug`**](#output-slug): *(`string`)*<a name="output-slug"></a>

  The Slug of the team.

- [**`team`**](#output-team): *(`object(team)`)*<a name="output-team"></a>

  The full team object.

- [**`team_members`**](#output-team_members): *(`list(team_members)`)*<a name="output-team_members"></a>

  A list of all team members (when using github_team_members).

- [**`team_memberships`**](#output-team_memberships): *(`list(team_membership)`)*<a name="output-team_memberships"></a>

  A list of all team memberships (when using github_team_membership).

- [**`team_repositories`**](#output-team_repositories): *(`list(team_repository)`)*<a name="output-team_repositories"></a>

  A list of all team repositories.

## External Documentation

### GitHub Provider Documentation

- https://registry.terraform.io/providers/integrations/github/latest/docs

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

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## GitHub as Code

[GitHub as Code][github-as-code] is a commercial solution built on top of
our open-source Terraform modules for GitHub. It helps our customers to
manage their GitHub organization more efficiently by enabling anyone in
their organization to self-service manage on- and offboarding of users,
repositories, and settings such as branch protections, secrets, and more
through code.

For details please see [https://www.mineiros.io/github-as-code][github-as-code].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-github-team
[github-as-code]: https://mineiros.io/github-as-code?ref=terraform-github-team
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-github-team/workflows/CI/CD%20Pipeline/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-github-team.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-github-team/actions
[releases-github]: https://github.com/mineiros-io/terraform-github-team/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gh]: https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform
[releases-github-provider]: https://github.com/terraform-providers/terraform-provider-github/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-github-team/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-github-team/tree/main/examples
[issues]: https://github.com/mineiros-io/terraform-github-team/issues
[license]: https://github.com/mineiros-io/terraform-github-team/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-github-team/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-github-team/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-github-team/blob/main/CONTRIBUTING.md
[github teams]: https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/organizing-members-into-teams
