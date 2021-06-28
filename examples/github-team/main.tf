# ----------------------------------------------------------------------------------------------------------------------
# CREATE A TEAM AND TWO REPOSITORIES
#
# We create a team and two repositories. The team will have pull permissions for one repository and push permissions
# for the other. We also add lists of members and maintainers to the team.
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES:
# ----------------------------------------------------------------------------------------------------------------------
# You can provide your credentials via the
#   AWS_ACCESS_KEY_ID and
#   AWS_SECRET_ACCESS_KEY, environment variables,
# representing your AWS Access Key and AWS Secret Key, respectively.
# Note that setting your AWS credentials using either these (or legacy)
# environment variables will override the use of
#   AWS_SHARED_CREDENTIALS_FILE and
#   AWS_PROFILE.
# The
#   AWS_DEFAULT_REGION and
#   AWS_SESSION_TOKEN environment variables are also used, if applicable.
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# Provider Setup
# ----------------------------------------------------------------------------------------------------------------------

provider "aws" {
  region = "eu-west-1"
}

resource "github_repository" "repository" {
  name = "engineering-tools"
}

resource "github_repository" "another_repository" {
  name = "devops-tools"
}

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
  version = "~> 0.6.0"

  name           = "DevOps"
  parent_team_id = module.team.id
  privacy        = "closed"
}
