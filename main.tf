resource "github_team" "team" {
  name           = var.name
  description    = var.description
  privacy        = var.privacy
  parent_team_id = var.parent_team_id
  ldap_dn        = var.ldap_dn
}

locals {
  members = { for m in var.members : lower(m.username) => merge({
    role = "member"
  }, m) }
}

resource "github_team_membership" "team_membership" {
  for_each = local.members

  team_id  = github_team.team.id
  username = each.value.username
  role     = each.value.role
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
