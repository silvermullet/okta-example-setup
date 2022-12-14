resource "okta_user" "zane_smith" {
  first_name         = "Zane"
  last_name          = "Smith"
  login              = "sepulworld@gmail.com"
  email              = "sepulworld@gmail.com"
  city               = "New York"
  cost_center        = "10"
  country_code       = "US"
  department         = "IT"
  display_name       = "Dr. John Smith"
  division           = "Acquisitions"
  employee_number    = "111111"
  honorific_prefix   = "Dr."
  honorific_suffix   = "Jr."
  locale             = "en_US"
  mobile_phone       = "1112223333"
  nick_name          = "Johnny"
  organization       = "Testing Inc."
  postal_address     = "1234 Testing St."
  preferred_language = "en-us"
  primary_phone      = "4445556666"
  profile_url        = "https://www.example.com/profile"
  second_email       = "john.smith.fun@example.com"
  state              = "NY"
  street_address     = "5678 Testing Ave."
  timezone           = "America/New_York"
  title              = "Director"
  user_type          = "Employee"
  zip_code           = "11111"
}

resource "okta_app_user" "zane_smith_aws_eng_support" {
  app_id   = okta_app_saml.eng_support_role.id
  user_id  = okta_user.zane_smith.id
  username = "Zane Smith"
}

resource "okta_app_user" "zane_smith_aws_admin_support" {
  app_id   = okta_app_saml.eng_admin_role.id
  user_id  = okta_user.zane_smith.id
  username = "Zane Smith"
}
