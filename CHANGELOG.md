# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.9.0]

### Added

- Add support for Terraform GitHub Provider version `5.x`

## [0.8.0]

### Added

- Automatically remove maintainers from members to resolve conflicts on the fly
- BREAKING CHANGE: Add support for `module_enabled`
- BREAKING CHANGE: Drop support for broken terraform `1.1.0` and `1.1.1` which might corrupt terraform state.
- BREAKING CHANGE: Drop inputs from outpus
- Add support for default maintainer

## [0.7.0]

### BREAKING CHANGES

We dropped support for Terraform pre 1.0 and GitHub Terraform Provider pre 4.0.
In addition we changed to the `integrations/github` official GitHub Terraform Provider.
This needs migration actions if you already used this module with the `hashicorp/github` provider and want to upgrade.

#### Migration from previous versions

To migrate from a previous version, please ensure that you are using the
`integrations/github` official GitHub Terraform Provider.

```hcl
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

Once you've updated the provider, a manual state migration is required to
migrate existing resources to the new provider.
The following command will replace the provider in the state.

```bash
terraform state replace-provider registry.terraform.io/hashicorp/github registry.terraform.io/integrations/github
```

After you've migrated the state, please run
`terrafrm init` to apply the changes to the resources.

### Added

- Add support for Official GitHub Terraform Provider `integrations/github`

### Removed

- Removed support for Terraform < 1.0
- Removed support for GitHub Provider < 4.0
- Removed compatibility to Hashicorp GitHub Terraform Provider `hashicorp/github`

## [0.6.0]

- Add support for Terraform `v1`

## [0.5.2]

### Fixed

- Fix the bug where `repo_maintain` uses `repo_admin` to set maintain
  permissions and `repo_triage` uses `repo_push` to set triage permissions

## [0.5.1]

### Added

- Add support for `admin`, `maintain` and `triage` repositories permissions

## [0.5.0]

### Added

- Add support for Terraform `v0.15`

### Fixed

- Preserve case of user names added to teams in plan output

## [0.4.0]

### Added

- Add support for Github Provider `v4`

## [0.3.1]

### Changed

- Tests now check for idem-potency after applying

### Fixed

- Fixed non-idem-potent applies when referencing repositories with uppercase letters in names (#31)

## [0.3.0]

### Added

- Add support for Terraform `v0.14`

## [0.2.0]

### Added

- Add `CHANGELOG.md`
- Add support for Terraform `v0.13`
- Add support for Terraform Github Provider `v3`
- Prepare support for Terraform `v0.14` (needs terraform `v0.12.20` or above)

### Changed

- Switch CI from SemaphoreCI to GitHub Actions

## [0.1.3] - 2020-03-05

### Added

- New format for README.md and LICENSE.

## [0.1.2] - 2020-03-03

### Added

- Upgrade the Github provider to version `v2.4`

## [0.1.1] - 2020-03-02

### Added

- Sort go imports.

### Fixed

- Fix some typos in README.md.

## [0.1.0] - 2020-03-02

### Added

- Add readme in markdown syntax instead of asciidoc for `registry.terraform.io`.
- Use pre-commit hooks.
- Add a new Makefile for running common tasks.

### Changelog

- Split up tests and test outputs.

## [0.0.1] - 2020-01-15

### Added

- This is the initial release of our terraform-github-team module that supports
  Team, Nested Team, Memberships, Team Repositories.

[unreleased]: https://github.com/mineiros-io/terraform-github-team/compare/v0.9.0...HEAD
[0.9.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.5.2...v0.6.0
[0.5.2]: https://github.com/mineiros-io/terraform-github-team/compare/v0.5.1...v0.5.2
[0.5.1]: https://github.com/mineiros-io/terraform-github-team/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/mineiros-io/terraform-github-team/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.1.3...v0.2.0
[0.1.3]: https://github.com/mineiros-io/terraform-github-team/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/mineiros-io/terraform-github-team/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/mineiros-io/terraform-github-team/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/mineiros-io/terraform-github-team/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/mineiros-io/terraform-github-team/releases/tag/v0.0.1
