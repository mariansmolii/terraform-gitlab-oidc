resource "aws_iam_openid_connect_provider" "this" {
  count = var.create_oidc_provider ? 1 : 0

  url            = var.gitlab_url
  client_id_list = [var.aud_value]
}

data "aws_iam_openid_connect_provider" "this" {
  count = var.create_oidc_provider ? 0 : 1

  arn = var.iam_openid_connect_provider_arn
}

data "aws_iam_policy_document" "this" {
  for_each = var.gitlab_oidc_roles

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [try(aws_iam_openid_connect_provider.this[0].arn, data.aws_iam_openid_connect_provider.this[0].arn)]
    }
    condition {
      test     = "StringLike"
      variable = "${try(aws_iam_openid_connect_provider.this[0].url, data.aws_iam_openid_connect_provider.this[0].url)}:${each.value.match_field}"
      values   = [each.value.repo_path]
    }
  }
}


resource "aws_iam_role" "this" {
  for_each = var.gitlab_oidc_roles

  name                 = each.value.role_name
  assume_role_policy   = data.aws_iam_policy_document.this[each.key].json
  max_session_duration = each.value.max_session_duration
  path                 = each.value.role_path
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for role_key, role in var.gitlab_oidc_roles : [
        for policy_arn in role.policy_arns : {
          key        = "${role_key}-${basename(policy_arn)}"
          role_name  = role.role_name
          policy_arn = policy_arn
        }
      ]
    ]) : item.key => item
  }

  role       = each.value.role_name
  policy_arn = each.value.policy_arn

  depends_on = [
    aws_iam_role.this
  ]
}
