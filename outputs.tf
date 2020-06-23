# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

output "id" {
  description = "The ID of the team."
  value       = github_team.team.id
}

output "team_name" {
  description = "The name of the team."
  value       = github_team.team.name
}

output "slug" {
  description = "The Slug of the team."
  value       = github_team.team.slug
}

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "team" {
  description = "The full team object."
  value       = github_team.team
}

output "team_memberships" {
  description = "A list of all team memberships."
  value       = github_team_membership.team_membership
}

output "team_repositories" {
  description = "A list of all team repositories"
  value       = github_team_repository.team_repository
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

output "name" {
  description = "The name of the team."
  value       = var.name
}

output "description" {
  description = "The description of the team."
  value       = var.description
}

output "privacy" {
  description = "The level of privacy for the team. Must be one of secret or closed."
  value       = var.privacy
}

output "parent_team_id" {
  description = "The ID of the parent team, if this is a nested team."
  value       = var.parent_team_id
}

output "ldap_dn" {
  description = "The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise."
  value       = var.ldap_dn
}

output "maintainers" {
  description = "The list of users that will be added to the current team with maintainer permissions."
  value       = var.maintainers
}

output "members" {
  description = "The list of users that will be added to the current team with member permissions."
  value       = var.members
}

output "admin_repositories" {
  description = "The list of repository names the current team should get admin (full) permission to."
  value       = var.admin_repositories
}

output "push_repositories" {
  description = "The list of repository names the current team should get push (read-write) permission to."
  value       = var.push_repositories
}

output "pull_repositories" {
  description = "The list of repository names the current team should get pull (read-only) permission to."
  value       = var.pull_repositories
}

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
