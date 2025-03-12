output "client_id" {
  value = aws_cognito_user_pool_client.userpool_client.id
  description = "ID of the created Cognito User Pool Client"
}

output "client_secret" {
    value = aws_cognito_user_pool_client.userpool_client.client_secret
    description = "Client secret of the created Cognito User Pool Client"
}