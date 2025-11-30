module "gitlab_oidc_example" {
  source = "../"

  create_oidc_provider = true

  gitlab_oidc_roles = {
    example_project_one = {
      role_name   = "example-project-one-role"
      repo_path   = "project-one/*"
      match_field = "sub"
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
      path        = "/example/"
    },
    example_project_two = {
      role_name   = "example-project-two-role"
      repo_path   = "project-two/*"
      match_field = "sub"
      policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    },
  }
}
