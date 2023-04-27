# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

output "id" {
  description = "The ID of the team."
  value       = try(github_team.team[0].id, null)
}

output "name" {
  description = "The name of the team."
  value       = try(github_team.team[0].name, null)
}

output "slug" {
  description = "The Slug of the team."
  value       = try(github_team.team[0].slug, null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "team" {
  description = "The full team object."
  value       = one(github_team.team)
}

output "team_members" {
  description = "A list of all team members (when using github_team_members)."
  value       = github_team_members.team_members
}

output "team_memberships" {
  description = "A list of all team memberships (when using github_team_membership)."
  value       = github_team_membership.team_membership
}

output "team_repositories" {
  description = "A list of all team repositories"
  value       = github_team_repository.team_repository
}

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------
