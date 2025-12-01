# GitLab OIDC Provider for AWS

Terraform module to create AWS IAM OIDC provider and roles for GitLab CI/CD pipelines authentication.

## Usage

To run this example you need to execute:

```bash
  terraform init
  terraform plan
  terraform apply
```

```hcl
module "gitlab_oidc" {
  source = "mariansmolii/oidc/gitlab"

  create_oidc_provider = true

  gitlab_oidc_roles = {
    example_project_one = {
      role_name   = "example-project-one-role"
      repo_path   = "project-one/*"
      match_field = "sub"
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
      role_path   = "/example/"
    },
    example_project_two = {
      role_name   = "example-project-two-role"
      repo_path   = "project-two/*"
      match_field = "sub"
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
      role_tags = {
        Environment = "dev"
      }
    }
  }
}
```
