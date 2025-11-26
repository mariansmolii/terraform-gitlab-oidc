output "oidc_roles_arns" {
  description = "A map of the created IAM role names to their ARNs"
  value = {
    for key, role in aws_iam_role.this :
    key => role.arn
  }
}
