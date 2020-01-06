variable "name" {
  type        = string
  description = "The name of the team."
}

variable "description" {
  type        = string
  description = "A description of the team."
  default     = ""
}

variable "privacy" {
  type        = string
  description = "The level of privacy for the team. Must be one of secret or closed."
  default     = "secret"
}

variable "parent_team_id" {
  type        = number
  description = "The ID of the parent team, if this is a nested team."
  default     = null
}

variable "ldap_dn" {
  type        = string
  description = "The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise."
  default     = null
}

variable "maintainers" {
  type        = list(string)
  description = "A list of users that will be added to the current team with maintainer permissions."
  default     = []
}

variable "members" {
  type        = list(string)
  description = "A list of users that will be added to the current team with member permissions."
  default     = []
}

variable "admin_repositories" {
  type        = list(string)
  description = "A list of repository names the current team should get admin (full) permission to."
  default     = []
}

variable "push_repositories" {
  type        = list(string)
  description = "A list of repository names the current team should get push (read-write) permission to."
  default     = []
}

variable "pull_repositories" {
  type        = list(string)
  description = "A list of repository names the current team should get pull (read-only) permission to."
  default     = []
}
