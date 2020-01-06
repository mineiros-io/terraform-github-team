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

variable "members" {
  type = list(object({
    username = string
    role     = string
  }))
  description = "A list of users that should be invited to the current team. Role must must be one of member or maintainer."
  default     = []

  # Example:
  # collaborators = [
  #   {
  #     username   = "username1"
  #     role       = "member"
  #   },
  #   {
  #     username   = "username2"
  #     role       = "maintainer"
  #   }
  # ]
}

variable "repositories" {
  type = list(object({
    name       = string
    permission = string
  }))
  description = "The list of repositories this team should have access to. Permission must be one of pull, push, or admin."
  default     = []

  # Example:
  # repositories = [
  #   {
  #     name             = "test-repository-1"
  #     permission       = "pull"
  #   },
  #   {
  #     name             = "test-repository-2"
  #     permission       = "push"
  #   },
  #   {
  #     name             = "test-repository-3"
  #     permission       = "admin"
  #   }
  # ]
}
