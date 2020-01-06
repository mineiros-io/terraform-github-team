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
  repositories = { for r in var.repositories : lower(r.name) => merge({
    permission = "pull"
  }, r) }
}

resource "github_team_repository" "team_repository" {
  for_each = local.repositories

  repository = each.value.name
  team_id    = github_team.team.id
  permission = each.value.permission
}
