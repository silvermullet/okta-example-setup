resource "okta_app_saml" "eng_support_role" {
  preconfigured_app = "amazon_aws"
  label             = "Amazon AWS - Engineer Support Role"
  status            = "ACTIVE"
  users {
    id       = okta_user.zane_smith.id
    username = okta_user.zane_smith.email
  }
}

resource "okta_app_saml" "eng_admin_role" {
  preconfigured_app = "amazon_aws"
  label             = "Amazon AWS - Admin Role"
  status            = "ACTIVE"
  users {
    id       = okta_user.zane_smith.id
    username = okta_user.zane_smith.email
  }
}

resource "aws_iam_saml_provider" "idp_eng_support_saml" {
  name                   = "idp_eng_support_saml"
  saml_metadata_document = okta_app_saml.eng_support_role.metadata
}

resource "aws_iam_saml_provider" "idp_eng_admin_saml" {
  name                   = "idp_eng_admin_saml"
  saml_metadata_document = okta_app_saml.eng_admin_role.metadata
}


// Engineer Support Role
module "iam_assumable_role_eng_support" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-saml"

  create_role = true

  role_name = "aws-eng-support-role"

  tags = {
    Role = "eng-support-role"
  }

  provider_id = aws_iam_saml_provider.idp_eng_support_saml.id

  // Basic Engineer Support Role
  role_policy_arns = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSSupportAccess"
  ]
}

// Engineer Admin Role
module "iam_assumable_role_eng_admin" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-saml"

  create_role = true

  role_name = "aws-eng-admin-role"

  tags = {
    Role = "eng-admin-role"
  }

  provider_id = aws_iam_saml_provider.idp_eng_admin_saml.id

  // Engineer Admin Role
  role_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}
