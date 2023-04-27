header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-github-team"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-github-team/workflows/CI/CD%20Pipeline/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-github-team/actions"
    text  = "Build Status"
  }

  badge "semver)" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-github-team.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-github-team/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gh" {
    image = "https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-github/releases"
    text  = "Github Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-github-team"
  toc     = true
  content = <<-END
    A [Terraform] module that offers a more convenient and tested way to provision and manage [GitHub teams].

    **_This module supports Terraform v1.x and is compatible with the Official Terraform GitHub Provider v4.x from `integrations/github`._**

    **Attention: This module is incompatible with the Hashicorp GitHub Provider! The latest version of this module supporting `hashicorp/github` provider is `~> 0.6.0`**
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module supports the following resources:

      - Team
      - Nested Team
      - Memberships
      - Team Repositories
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
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
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Main Resource Configuration"

      variable "name" {
        required    = true
        type        = string
        description = <<-END
          The name of the team.
        END
      }

      variable "description" {
        type        = string
        default     = ""
        description = <<-END
          A description of the team.
        END
      }

      variable "privacy" {
        type        = string
        default     = "secret"
        description = <<-END
          The level of privacy for the team. Must be one of `secret` or `closed`.
        END
      }

      variable "parent_team_id" {
        type        = number
        description = <<-END
          The ID of the parent team, if this is a nested team.

          Default is to create a root team without a parent.
        END
      }

      variable "ldap_dn" {
        type        = string
        description = <<-END
          The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise.
        END
      }

      variable "create_default_maintainer" {
        type        = bool
        default     = false
        description = <<-END
          Adds the creating user to the team when set to `true`."
        END
      }
    }

    section {
      title = "Extended Resource Configuration"

      section {
        title = "Team membership"

        variable "maintainers" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of users that will be added to the current team with maintainer permissions.
          END
        }

        variable "members" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of users that will be added to the current team with member permissions.
          END
        }
      }

      section {
        title = "Team repository access"

        variable "admin_repositories" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of repository names the current team should get [admin](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.
          END
        }

        variable "maintain_repositories" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of repository names the current team should get [maintain](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.
          END
        }

        variable "push_repositories" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of repository names the current team should get [push (read-write)](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.
          END
        }

        variable "triage_repositories" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of repository names the current team should get [push (triage)](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.
          END
        }

        variable "pull_repositories" {
          type        = set(string)
          default     = []
          description = <<-END
            A list of repository names the current team should get [pull (read-only)](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization#repository-roles-for-organizations) permission to.
          END
        }
      }
    }

    section {
      title = "Module Configuration"

      variable "module_depends_on" {
        type        = list(any)
        default     = []
        description = <<-END
          A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
        END
      }

      variable "module_enabled" {
        type        = bool
        default     = true
        description = <<-END
          Specifies whether resources in the module will be created.
        END
      }

      variable "module_use_members" {
        type        = bool
        default     = false
        description = <<-END
          Wether to use github_team_members or github_team_membership.
        END
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:
    END

    output "id" {
      type        = string
      description = <<-END
        The ID of the team.
      END
    }

    output "name" {
      type        = string
      description = <<-END
        The name of the team.
      END
    }

    output "slug" {
      type        = string
      description = <<-END
        The Slug of the team.
      END
    }

    output "team" {
      type        = object(team)
      description = <<-END
        The full team object.
      END
    }

    output "team_members" {
      type        = list(team_members)
      description = <<-END
        A list of all team members (when using github_team_members).
      END
    }

    output "team_memberships" {
      type        = list(team_membership)
      description = <<-END
        A list of all team memberships (when using github_team_membership).
      END
    }

    output "team_repositories" {
      type        = list(team_repository)
      description = <<-END
        A list of all team repositories.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "GitHub Provider Documentation"
      content = <<-END
        - https://registry.terraform.io/providers/integrations/github/latest/docs
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "GitHub as Code"
    content = <<-END
      [GitHub as Code][github-as-code] is a commercial solution built on top of
      our open-source Terraform modules for GitHub. It helps our customers to
      manage their GitHub organization more efficiently by enabling anyone in
      their organization to self-service manage on- and offboarding of users,
      repositories, and settings such as branch protections, secrets, and more
      through code.

      For details please see [https://www.mineiros.io/github-as-code][github-as-code].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-github-team"
  }
  ref "github-as-code" {
    value = "https://mineiros.io/github-as-code?ref=terraform-github-team"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-github-team/workflows/CI/CD%20Pipeline/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-github-team.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-github-team/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-github-team/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "badge-tf-gh" {
    value = "https://img.shields.io/badge/GH-4.x-F8991D.svg?logo=terraform"
  }
  ref "releases-github-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-github/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "aws" {
    value = "https://aws.amazon.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-github-team/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-github-team/tree/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-github-team/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-github-team/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-github-team/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-github-team/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-github-team/blob/main/CONTRIBUTING.md"
  }
  ref "github teams" {
    value = "https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/organizing-members-into-teams"
  }
}
