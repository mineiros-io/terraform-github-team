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

variable "name" {
  description = "The name of the team."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  description = "A description of the team."
  type        = string
  default     = ""
}

variable "privacy" {
  description = "The level of privacy for the team. Must be one of secret or closed."
  type        = string
  default     = "secret"
}

variable "parent_team_id" {
  description = "The ID of the parent team, if this is a nested team."
  type        = number
  default     = null
}

variable "ldap_dn" {
  description = "The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise."
  type        = string
  default     = null
}

variable "maintainers" {
  description = "A list of users that will be added to the current team with maintainer permissions."
  #
  # Example:
  #
  # maintainers = [
  #   "bob",
  #   "alice"
  # ]
  #
  type    = set(string)
  default = []
}

variable "members" {
  description = "A list of users that will be added to the current team with member permissions."
  type        = set(string)
  #
  # Example:
  #
  # members = [
  #   "bob",
  #   "alice"
  # ]
  #
  default = []
}

variable "admin_repositories" {
  description = "A list of repository names the current team should get admin (full) permission to."
  type        = set(string)
  #
  # Example:
  #
  # admin_reporitores = [
  #   "bob",
  #   "alice"
  # ]
  #
  default = []
}

variable "push_repositories" {
  description = "A list of repository names the current team should get push (read-write) permission to."
  type        = set(string)
  default     = []
}

variable "pull_repositories" {
  description = "A list of repository names the current team should get pull (read-only) permission to."
  type        = set(string)
  default     = []
}
