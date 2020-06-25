# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ---------------------------------------------------------------------------------------------------------------------

# GITHUB_TOKEN
# GITHUB_ORGANIZATION

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "a-repository-name" {
  description = "The name of the first repository that we create."
  type        = string
  default     = "terraform-github-team-module-test-repository-1"
}
variable "b-repository-name" {
  description = "The name of the second repository that we create."
  type        = string
  default     = "terraform-github-team-module-test-repository-2"
}

variable "team_name" {
  description = "The name of the team."
  type        = string
  default     = "test-team"
}

variable "team_description" {
  description = "The description of the team."
  type        = string
  default     = "This team is created with terraform to test the terraformn-github-repository module."
}

variable "team_privacy" {
  description = "The level of privacy for the team. Must be one of secret or closed."
  type        = string
  default     = "closed"
}

variable "members" {
  description = "A set of users that should be added to the team as members."
  type        = set(string)
  default = [
    "terraform-test-user-1"
  ]
}

variable "maintainers" {
  description = "A set of users that should be added to the team as maintainers."
  type        = set(string)
  default = [
    "terraform-test-user-2"
  ]
}

variable "nested_team_name" {
  description = "The description of the team."
  type        = string
  default     = "a-nested-team"
}

variable "nested_team_privacy" {
  description = "The level of privacy for the team."
  type        = string
  default     = "closed"
}
