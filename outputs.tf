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

output "team" {
  description = "The full team object."
  value       = try(github_team.team[0], {})
}

output "team_memberships" {
  description = "A list of all team memberships."
  value       = try(github_team_membership.team_membership[0], null)
}

output "team_repositories" {
  description = "A list of all team repositories"
  value       = try(github_team_repository.team_repository[0], null)
}
