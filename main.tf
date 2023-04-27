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
  count = var.module_enabled ? 1 : 0

  name           = var.name
  description    = var.description
  privacy        = var.privacy
  parent_team_id = var.parent_team_id
  ldap_dn        = var.ldap_dn

  create_default_maintainer = var.create_default_maintainer

  depends_on = [var.module_depends_on]
}

locals {
  maintainers = { for i in var.maintainers : lower(i) => { role = "maintainer", username = i } }
  members     = { for i in setsubtract(var.members, var.maintainers) : lower(i) => { role = "member", username = i } }

  memberships = merge(local.maintainers, local.members)
}

resource "github_team_members" "team_members" {
  count = var.module_enabled && var.module_use_members ? 1 : 0

  team_id = try(github_team.team[0].id, null)

  dynamic "members" {
    for_each = { for m in local.memberships : m.username => m }
    content {
      username = members.value.username
      role     = members.value.role
    }
  }

  depends_on = [var.module_depends_on]
}

resource "github_team_membership" "team_membership" {
  for_each = var.module_enabled && !var.module_use_members ? local.memberships : {}

  team_id  = try(github_team.team[0].id, null)
  username = each.value.username
  role     = each.value.role

  depends_on = [var.module_depends_on]
}

locals {
  repo_admin    = { for i in var.admin_repositories : lower(i) => { permission = "admin", repository = i } }
  repo_maintain = { for i in var.maintain_repositories : lower(i) => { permission = "maintain", repository = i } }
  repo_push     = { for i in var.push_repositories : lower(i) => { permission = "push", repository = i } }
  repo_triage   = { for i in var.triage_repositories : lower(i) => { permission = "triage", repository = i } }
  repo_pull     = { for i in var.pull_repositories : lower(i) => { permission = "pull", repository = i } }

  repositories = merge(local.repo_admin, local.repo_maintain, local.repo_push, local.repo_triage, local.repo_pull)
}

resource "github_team_repository" "team_repository" {
  for_each = var.module_enabled ? local.repositories : {}

  repository = each.value.repository
  team_id    = try(github_team.team[0].id, null)
  permission = each.value.permission

  depends_on = [var.module_depends_on]
}
