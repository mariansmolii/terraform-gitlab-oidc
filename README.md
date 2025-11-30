# GitLab OIDC Terraform Module

Terraform module to create AWS IAM OIDC provider and roles for GitLab CI/CD pipelines authentication.

## Usage

```hcl
module "gitlab_oidc" {
  source = "github.com/mariansmolii/terraform-gitlab-oidc"

  create_oidc_provider = true

  gitlab_oidc_roles = {
    example_project_one = {
      role_name   = "example-project-one-role"
      repo_path   = "project-one/*"
      match_field = "sub"
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
      role_path        = "/example/"
    },
    example_project_two = {
      role_name   = "example-project-two-role"
      repo_path   = "project-two/*"
      match_field = "sub"
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    },
  }
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                   | Version  |
| ------------------------------------------------------ | -------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 6.0.0 |

## Providers

| Name                                             | Version  |
| ------------------------------------------------ | -------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 6.0.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                               | Type        |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider)    | resource    |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                          | resource    |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)      | resource    |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                 | data source |

## Inputs

| Name                                                                                                                           | Description                                                                       | Type                                                                                                                                                                                                                                                  | Default                | Required |
| ------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------- | :------: |
| <a name="input_aud_value"></a> [aud_value](#input_aud_value)                                                                   | The audience value to use for the OIDC provider                                   | `string`                                                                                                                                                                                                                                              | `"https://gitlab.com"` |    no    |
| <a name="input_create_oidc_provider"></a> [create_oidc_provider](#input_create_oidc_provider)                                  | Whether to create a new IAM OIDC provider or use an existing one                  | `bool`                                                                                                                                                                                                                                                | `true`                 |    no    |
| <a name="input_gitlab_oidc_roles"></a> [gitlab_oidc_roles](#input_gitlab_oidc_roles)                                           | A map of roles to create for GitLab OIDC authentication                           | <pre>map(object({<br/> role_name = string<br/> repo_path = string<br/> match_field = optional(string, "sub")<br/> policy_arns = list(string)<br/> max_session_duration = optional(number, 3600)<br/> role_path = optional(string, "/")<br/> }))</pre> | n/a                    |   yes    |
| <a name="input_gitlab_url"></a> [gitlab_url](#input_gitlab_url)                                                                | The URL of the GitLab instance to use as the OIDC provider                        | `string`                                                                                                                                                                                                                                              | `"https://gitlab.com"` |    no    |
| <a name="input_iam_openid_connect_provider_arn"></a> [iam_openid_connect_provider_arn](#input_iam_openid_connect_provider_arn) | The ARN of the existing IAM OIDC provider to use if create_oidc_provider is false | `string`                                                                                                                                                                                                                                              | `null`                 |    no    |

## Outputs

| Name                                                                                   | Description                                       |
| -------------------------------------------------------------------------------------- | ------------------------------------------------- |
| <a name="output_oidc_provider_arn"></a> [oidc_provider_arn](#output_oidc_provider_arn) | The ARN of the IAM OIDC provider                  |
| <a name="output_oidc_roles_arns"></a> [oidc_roles_arns](#output_oidc_roles_arns)       | A map of the created IAM role names to their ARNs |

<!-- END_TF_DOCS -->
