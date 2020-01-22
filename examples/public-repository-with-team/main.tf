terraform {
  required_version = "~> 0.12.9"
}

provider "github" {
  version = "~> 2.3"
}

resource "github_repository" "repository" {
  name = "terraform-github-team-module-test-repository-1"
}

resource "github_repository" "another_repository" {
  name = "terraform-github-team-module-test-repository-2"
}

module "team" {
  source      = "../.."
  name        = "test-team"
  description = "This team is created with terraform to test the terraformn-github-repository module."
  privacy     = "closed"

  members = [
    "terraform-test-user-1"
  ]

  maintainers = [
    "terraform-test-user-2"
  ]

  pull_repositories = [
    github_repository.repository.name,
  ]

  push_repositories = [
    github_repository.another_repository.name,
  ]
}

module "nested_team" {
  source         = "../.."
  name           = "nested-test-team"
  parent_team_id = module.team.id
  privacy        = "closed"
}
