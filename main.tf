resource "okta_app_saml" "test" {
  preconfigured_app = "amazon_aws"
  label             = "Amazon AWS"
  status            = "ACTIVE"
}

resource "aws_iam_saml_provider" "idp_saml" {
  name                   = "idp_saml"
  saml_metadata_document = okta_app_saml.test.metadata
}


module "iam_assumable_role_admin" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-saml"

  create_role = true

  role_name = "aws-eng-support-role"

  tags = {
    Role = "eng-support-role"
  }

  provider_id = aws_iam_saml_provider.idp_saml.id

  // Basic Engineer Support Role
  role_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSSupportAccess"
  ]
}
