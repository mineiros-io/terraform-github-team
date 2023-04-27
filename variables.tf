# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "(Required) The name of the team."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  description = "(Optional) A description of the team."
  type        = string
  default     = ""
}

variable "privacy" {
  description = "(Optional) The level of privacy for the team. Must be one of secret or closed."
  type        = string
  default     = "secret"
}

variable "parent_team_id" {
  description = "(Optional) The ID of the parent team, if this is a nested team."
  type        = number
  default     = null
}

variable "ldap_dn" {
  description = "(Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise."
  type        = string
  default     = null
}

variable "maintainers" {
  description = "(Optional) A list of users that will be added to the current team with maintainer permissions."
  type        = set(string)
  default     = []
}

variable "members" {
  description = "(Optional) A list of users that will be added to the current team with member permissions."
  type        = set(string)
  default     = []
}

variable "create_default_maintainer" {
  type        = string
  description = "(Optional) Adds the creating user to the team when set to `true`."
  default     = false
}

variable "admin_repositories" {
  description = "(Optional) A list of repository names the current team should get admin (full) permission to."
  type        = set(string)
  default     = []
}

variable "maintain_repositories" {
  description = "(Optional) A list of repository names the current team should get push (maintain) permission to."
  type        = set(string)
  default     = []
}

variable "push_repositories" {
  description = "(Optional) A list of repository names the current team should get push (read-write) permission to."
  type        = set(string)
  default     = []
}

variable "triage_repositories" {
  description = "(Optional) A list of repository names the current team should get push (triage) permission to."
  type        = set(string)
  default     = []
}

variable "pull_repositories" {
  description = "(Optional) A list of repository names the current team should get pull (read-only) permission to."
  type        = set(string)
  default     = []
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------


variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether or not to create resources within the module."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is []."
  default     = []
}

variable "module_use_members" {
  type        = bool
  description = "(Optional) Wether to use github_team_members or github_team_membership."
  default     = false
}
