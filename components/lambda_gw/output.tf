output "api_gateway_id" {
  description = "ID of the created API Gateway"
  value       = aws_apigatewayv2_api.api_gateway.id
}

output "api_gateway_authorizer_id" {
  description = "ID of the API Gateway Cognito Authorizer"
  value       = aws_apigatewayv2_authorizer.api_authorizer.id
}
