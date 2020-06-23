output "first_repository_name" {
  description = "The name of the first repository."
  value       = github_repository.repository.name
}

output "second_repository_name" {
  description = "The name of the second repository."
  value       = github_repository.another_repository.name
}

output "team" {
  description = "All outputs of the team module."
  value       = module.team
}

output "team_name" {
  description = "The name of the main team."
  value       = module.team.name
}

output "child_team" {
  description = "All outputs of the child team.1"
  value       = module.child_team
}
