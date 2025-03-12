resource "aws_apigatewayv2_api" "api_gateway" {
  name        = "${var.project_key}-${var.api_name}"
  description = "API Gateway for ${var.project_key}-${var.api_name}"

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.api_name}" }
  )
}

resource "aws_apigatewayv2_integration" "api_lambda_integration" {
  api_id           = aws_apigatewayv2_api.api_gateway.id
  integration_type = "HTTP_PROXY"

  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda Integration"
  integration_method        = var.integration_method
  integration_uri           = var.lambda_invoke_arn
}

resource "aws_apigatewayv2_authorizer" "api_authorizer" {
  api_id                            = aws_apigatewayv2_api.api_gateway.id
  authorizer_type                   = "JWT"
  authorizer_uri                    = var.lambda_invoke_arn
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "${var.project_key}-${var.api_name}-authorizer"
  authorizer_payload_format_version = "2.0"
  jwt_configuration {
    audience = [var.jwt_audience]
    issuer   = var.jwt_issuer
  }
}

resource "aws_apigatewayv2_deployment" "deployment" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  description = "Deployment for ${var.project_key}-${var.api_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id = aws_apigatewayv2_api.api_gateway.id
  name   = var.stage_name
  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.api_name}" }
  )
}