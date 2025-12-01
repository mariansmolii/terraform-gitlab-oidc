variable "create_oidc_provider" {
  description = "Whether to create a new IAM OIDC provider or use an existing one"
  type        = bool
  default     = true
}

variable "iam_openid_connect_provider_arn" {
  description = "The ARN of the existing IAM OIDC provider to use if create_oidc_provider is false"
  type        = string
  default     = null
}

variable "gitlab_url" {
  description = "The URL of the GitLab instance to use as the OIDC provider"
  type        = string
  default     = "https://gitlab.com"
}

variable "aud_value" {
  description = "The audience value to use for the OIDC provider"
  type        = string
  default     = "https://gitlab.com"
}

variable "gitlab_oidc_roles" {
  description = "A map of roles to create for GitLab OIDC authentication"
  type = map(object({
    role_name            = string
    repo_path            = string
    match_field          = optional(string, "sub")
    policy_arns          = list(string)
    max_session_duration = optional(number, 3600)
    role_path            = optional(string, "/")
    role_tags            = optional(map(string))
  }))
}
