# ---------------------------------------------------------------------------------------------------------------------
# CREATE A GITHUB TEAM, TEAM MEMBERSHIPS AND ASSIGN THE TEAM TO REPOSITORIES WITH PERMISSIONS
#
# Create a Github team and add users as either members or maintainers. Users that aren't a member of the managed
# organization yet will receive an invite and hence not be part of the team before they accept the invitation and
# fulfill potential requirements such as enabled 2FA.
# This module also accepts a list of repositories to that the team can be added with "admin", "push", or "pull"
# permissions.
# ---------------------------------------------------------------------------------------------------------------------

resource "github_team" "team" {
  name           = var.name
  description    = var.description
  privacy        = var.privacy
  parent_team_id = var.parent_team_id
  ldap_dn        = var.ldap_dn
}

locals {
  maintainers = { for i in var.maintainers : lower(i) => "maintainer" }
  members     = { for i in var.members : lower(i) => "member" }

  memberships = merge(local.maintainers, local.members)
}

resource "github_team_membership" "team_membership" {
  for_each = local.memberships

  team_id  = github_team.team.id
  username = each.key
  role     = each.value
}

locals {
  repo_admin = { for i in var.admin_repositories : lower(i) => "admin" }
  repo_push  = { for i in var.push_repositories : lower(i) => "push" }
  repo_pull  = { for i in var.pull_repositories : lower(i) => "pull" }

  repositories = merge(local.repo_admin, local.repo_push, local.repo_pull)
}

resource "github_team_repository" "team_repository" {
  for_each = local.repositories

  repository = each.key
  team_id    = github_team.team.id
  permission = each.value
}
