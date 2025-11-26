output "oidc_roles_arns" {
  description = "A map of the created IAM role names to their ARNs"
  value = {
    for key, role in aws_iam_role.this :
    key => role.arn
  }
}

output "oidc_provider_arn" {
  description = "The ARN of the IAM OIDC provider"
  value       = try(aws_iam_openid_connect_provider.this[0].arn, null)
}
