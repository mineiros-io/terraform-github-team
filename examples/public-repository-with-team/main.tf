terraform {
  required_version = "~> 0.12.9"
}

provider "github" {
  token        = var.github_token
  organization = var.github_organization
}

resource "github_repository" "repository" {
  name   = "terraform-github-team-module-test-repository-1"
  topics = ["terrform", "integration-test"]
}

resource "github_repository" "another_repository" {
  name   = "terraform-github-team-module-test-repository-2"
  topics = ["terrform", "integration-test"]
}

module "team" {
  source      = "../.."
  name        = "test-team"
  description = "This team is created with terraform to test the terraformn-github-repository module."
  privacy     = "secret"

  members = [
    {
      username = "terraform-test-user-1"
      role     = "member"
    },
    {
      username = "terraform-test-user-2"
      role     = "maintainer"
    }
  ]

  repositories = [
    {
      name       = github_repository.repository.name,
      permission = "pull"
    },
    {
      name       = github_repository.another_repository.name,
      permission = "push"
    }
  ]
}

module "nested_team" {
  source         = "../.."
  name           = "nested-test-team"
  parent_team_id = module.team.id
}
