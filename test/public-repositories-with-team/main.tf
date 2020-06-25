# ---------------------------------------------------------------------------------------------------------------------
# CREATE A TEAM AND TWO REPOSITORIES
#
# We create a team and two repositories. The team will have pull permissions for one repository and push permissions
# for the other. We also add lists of members and maintainers to the team.
# ---------------------------------------------------------------------------------------------------------------------

resource "github_repository" "repository" {
  name = var.a-repository-name
}

resource "github_repository" "another_repository" {
  name = var.b-repository-name
}

module "team" {
  source = "../.."

  name        = var.team_name
  description = var.team_description
  privacy     = var.team_privacy

  members     = var.members
  maintainers = var.maintainers

  pull_repositories = [
    github_repository.repository.name,
  ]

  push_repositories = [
    github_repository.another_repository.name,
  ]
}

# Create a child team
module "child_team" {
  source = "../.."

  name           = var.nested_team_name
  parent_team_id = module.team.id
  privacy        = var.nested_team_privacy
}
