output "roles_arn" {
  value = module.gitlab_oidc_example.oidc_roles_arns
}

output "oidc_provider_arn" {
  value = module.gitlab_oidc_example.oidc_provider_arn
}
