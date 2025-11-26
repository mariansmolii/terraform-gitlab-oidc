module "gitlab_oidc_example" {
  source = "../"

  create_oidc_provider = true
  gitlab_oidc_roles    = local.oidc_roles
}
