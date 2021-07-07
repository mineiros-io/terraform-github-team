[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![license][badge-license]][apache20]
[![Terraform Version][badge-terraform]][releases-terraform]
[![Join Slack][badge-slack]][slack]

# Create a team which has access to two newly created repositories

This example shows how to create a team and two repositories.
The team will have pull permissions for one repository and push permissions
for the other. We also add lists of members and maintainers to the team.

## Basic usage

The code in [main.tf] defines two public GitHub repository and two nested
GitHub teams. The team will be granted pull permissions to the one repository
and push permissions to the other.

```hcl
module "team" {
  source  = "mineiros-io/team/github"
  version = "~> 0.6.0"

  name        = "Engineering"
  description = "This team is created with terraform to test the terraformn-github-repository module."
  privacy     = "closed"

  members     = ["alice"]
  maintainers = ["bob"]

  pull_repositories = [
    github_repository.repository.name,
  ]

  push_repositories = [
    github_repository.another_repository.name,
  ]
}

module "child_team" {
  source  = "mineiros-io/team/github"
  version = "~> 0.5.0"

  name           = "DevOps"
  parent_team_id = module.team.id
  privacy        = "closed"
}
```

## Running the example

### Cloning the repository

```bash
git clone https://github.com/mineiros-io/terraform-github-team.git
cd terraform-github-team/examples/github-team
```

### Initializing Terraform

Run `terraform init` to initialize the example and download providers and the module.

### Planning the example

Run `terraform plan` to see a plan of the changes.

### Applying the example

Run `terraform apply` to create the resources.
You will see a plan of the changes and Terraform will prompt you for approval to actually apply the changes.

### Destroying the example

Run `terraform destroy` to destroy all resources again.

<!-- References -->

<!-- markdown-link-check-disable -->

[main.tf]: https://github.com/mineiros-io/terraform-github-team/blob/master/examples/github-team/main.tf

<!-- markdown-link-check-enable -->

[homepage]: https://mineiros.io/?ref=terraform-github-team
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/terraform-1.x%20|0.15%20|0.14%20|%200.13%20|%200.12.20+-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://join.slack.com/t/mineiros-community/shared_invite/zt-ehidestg-aLGoIENLVs6tvwJ11w9WGg
