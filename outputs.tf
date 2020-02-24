output "id" {
  description = "The ID of the team."
  value       = github_team.team.id
}

output "name" {
  description = "The name of the team."
  value       = github_team.team.name
}

output "slug" {
  description = "The Slug of the team."
  value       = github_team.team.slug
}

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
