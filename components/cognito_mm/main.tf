resource "aws_cognito_user_pool" "user_pool" {
 name = "${var.project_key}-user-pool"
 account_recovery_setting {
   recovery_mechanism {
     name     = "admin_only"
     priority = 1
   }
 }
 admin_create_user_config {
   allow_admin_create_user_only = true
 }
}

resource "aws_cognito_user_pool_domain" "user_pool_integrations_domain" {
 domain       = "${var.project_key}-domain"
 user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                                 = "client"
  user_pool_id                         = aws_cognito_user_pool.user_pool.id
  callback_urls                        = ["https://example.com"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid"]
  supported_identity_providers         = ["COGNITO"]
  enable_token_revocation              = true
 generate_secret                      = true
}